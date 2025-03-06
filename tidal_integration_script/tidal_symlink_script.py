#!/usr/bin/env python3

import os
import re
import time
import shutil
import logging
import psutil
import subprocess
import socket
import platform
import argparse
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from pythonosc import udp_client

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

# Default paths (will be overridden by command line arguments if provided)
DEFAULT_SAMPLES_DIR = '/Samples'  # Default source directory to monitor
DEFAULT_TIDAL_SAMPLES_DIR = 'tidalSamples'  # Default root directory for symbolic links
AUDIO_EXTENSIONS = ('.wav', '.mp3', '.aif', '.aiff', '.flac')  # Common audio extensions

# OSC settings
OSC_IP = "127.0.0.1"  # localhost
OSC_PORT = 57209      # port to send OSC messages to

# Initialize global variables with default values (will be updated in main())
SAMPLES_DIR = DEFAULT_SAMPLES_DIR
TIDAL_SAMPLES_DIR = DEFAULT_TIDAL_SAMPLES_DIR
osc_client = None

def send_osc_load_samples(path):
    """Send an OSC message to SuperCollider to load samples from the given path"""
    if osc_client:
        try:
            # Format the path with wildcards to load all samples
            formatted_path = os.path.join(path, "*")
            logging.info(f"Sending OSC message to load samples from: {formatted_path}")
            osc_client.send_message("/tidal/loadSamples", formatted_path)
            return True
        except Exception as e:
            logging.error(f"Error sending OSC message: {e}")
            return False
    return False

def create_symlink(src_path):
    """
    Create a symbolic link for a file if it matches the pattern t_{folderName}_{filename} or t_{folderName} {filename}
    """
    # Skip directories
    if os.path.isdir(src_path):
        return
    
    # Check if the file is an audio file
    if not src_path.lower().endswith(AUDIO_EXTENSIONS):
        return
    
    # Extract the base filename
    file_name = os.path.basename(src_path)
    
    # Check if the file follows either pattern:
    # 1. t_{folderName}_{filename} - using underscore as separator
    # 2. t_{folderName} {filename} - using space as separator
    space_pattern = r'^t_([^ ]+) (.+)$'
    
    # Try both patterns
    match = re.match(space_pattern, file_name)
    
    if match:
        folder_name = 't_' + match.group(1)
        base_filename = match.group(2)
        logging.info(f"Processing file: {src_path} (folder: {folder_name}, filename: {base_filename})")
        
        # Create target directory if it doesn't exist
        target_dir = os.path.join(TIDAL_SAMPLES_DIR, folder_name)
        os.makedirs(target_dir, exist_ok=True)
        
        # Get the file creation time as timestamp
        timestamp = int(os.path.getctime(src_path))
        
        # Define the target path for the symlink - use absolute paths for consistency
        target_filename = f"{timestamp}_{base_filename}"
        target_path = os.path.join(os.path.abspath(target_dir), target_filename)
        
        # Get absolute path for source file
        abs_src_path = os.path.abspath(src_path)
        
        # Create a symbolic link
        try:
            # If a link with the same name already exists, remove it
            if os.path.exists(target_path):
                if os.path.islink(target_path):
                    os.unlink(target_path)
                else:
                    os.remove(target_path)
            
            # Create the symlink with absolute paths
            os.symlink(abs_src_path, target_path)
            logging.info(f"Created symlink: {target_path} -> {abs_src_path}")
            
            # Notify SuperCollider about the new sample
            # Get absolute path for the target
            abs_target_path = target_path  # Already absolute
            
            # Example SuperCollider code to handle a new sample
            # This assumes you have defined a function in SuperCollider called ~newSample
            # that takes a folder name and file path as arguments
            sc_code = f'~newSample.value("{folder_name}", "{abs_target_path.replace(os.sep, "/")}");'
            
            # Uncomment the line below to activate SuperCollider notification
            
        except Exception as e:
            logging.error(f"Error creating symlink: {e}")
    else:
        logging.debug(f"File {file_name} does not match the required pattern")

def process_existing_files():
    """
    Process all existing files in the SAMPLES_DIR
    """
    # Ensure we're using absolute path for consistency
    samples_dir_abs = os.path.abspath(SAMPLES_DIR)
    
    logging.info(f"Processing existing files in {samples_dir_abs}")
    try:
        for root, _, files in os.walk(samples_dir_abs):
            for file in files:
                src_path = os.path.join(root, file)
                create_symlink(src_path)
        logging.info("Finished processing existing files")
        
        # Send OSC message to load samples after processing
        send_osc_load_samples(os.path.abspath(TIDAL_SAMPLES_DIR))
        
    except Exception as e:
        logging.error(f"Error processing existing files: {e}")

class AudioFileHandler(FileSystemEventHandler):
    """
    Handler for file system events
    """
    def __init__(self):
        self.last_reload_time = 0
        self.reload_cooldown = 5  # seconds between sample directory reloads
    
    def on_created(self, event):
        """Handle file creation events"""
        if not event.is_directory:
            self.process_file(event.src_path)
            self.maybe_reload_samples()
            
    def on_modified(self, event):
        """Handle file modification events"""
        if not event.is_directory:
            self.process_file(event.src_path)
            self.maybe_reload_samples()
            
    def on_moved(self, event):
        """Handle file moved/renamed events"""
        if not event.is_directory:
            self.process_file(event.dest_path)
            self.maybe_reload_samples()
            
    def process_file(self, src_path):
        """Process a file by creating a symlink if it matches the criteria"""
        print("Processing file: ", src_path)
        create_symlink(src_path)
        
    def maybe_reload_samples(self):
        """Reload samples if cooldown period has passed"""
        current_time = time.time()
        if current_time - self.last_reload_time > self.reload_cooldown:
            self.last_reload_time = current_time
            # Send OSC message to reload samples
            samples_dir_abs = os.path.abspath(TIDAL_SAMPLES_DIR)
            send_osc_load_samples(samples_dir_abs)
            logging.info("Triggered sample reload via OSC")

def main():
    """Main function to set up and start the file system observer"""
    # Parse command line arguments
    parser = argparse.ArgumentParser(description='Monitor a directory for Tidal sample files and create symbolic links.')
    parser.add_argument('--samples-dir', '-s', dest='samples_dir', default=DEFAULT_SAMPLES_DIR,
                        help=f'Source directory to monitor (default: {DEFAULT_SAMPLES_DIR})')
    parser.add_argument('--tidal-dir', '-t', dest='tidal_dir', default=DEFAULT_TIDAL_SAMPLES_DIR,
                        help=f'Target directory for symbolic links (default: {DEFAULT_TIDAL_SAMPLES_DIR})')
    args = parser.parse_args()
    
    # Set the global variables based on command line arguments and convert to absolute paths
    global SAMPLES_DIR, TIDAL_SAMPLES_DIR, osc_client
    SAMPLES_DIR = os.path.abspath(args.samples_dir)
    TIDAL_SAMPLES_DIR = os.path.abspath(args.tidal_dir)
    
    # Initialize OSC client
    try:
        osc_client = udp_client.SimpleUDPClient(OSC_IP, OSC_PORT)
        logging.info(f"OSC client initialized to send to {OSC_IP}:{OSC_PORT}")
    except Exception as e:
        logging.error(f"Failed to initialize OSC client: {e}")
        osc_client = None
    
    logging.info(f"Monitoring directory: {SAMPLES_DIR}")
    logging.info(f"Creating symlinks in: {TIDAL_SAMPLES_DIR}")
    
    # Create tidalSamples directory if it doesn't exist
    os.makedirs(TIDAL_SAMPLES_DIR, exist_ok=True)
    
    # Process existing files first
    process_existing_files()
    
    # Set up the file system observer
    event_handler = AudioFileHandler()
    observer = Observer()
    
    # Check if the source directory exists
    if not os.path.exists(SAMPLES_DIR):
        logging.error(f"Source directory {SAMPLES_DIR} does not exist. Creating it.")
        try:
            os.makedirs(SAMPLES_DIR, exist_ok=True)
        except Exception as e:
            logging.error(f"Failed to create source directory: {e}")
            return
    
    observer.schedule(event_handler, SAMPLES_DIR, recursive=True)
    
    # Start the observer
    observer.start()
    logging.info(f"Started monitoring {SAMPLES_DIR}")
    
    try:
        # Keep the script running
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        # Stop the observer gracefully on keyboard interrupt
        observer.stop()
        logging.info("Monitoring stopped")
    
    observer.join()

if __name__ == "__main__":
    main()


















