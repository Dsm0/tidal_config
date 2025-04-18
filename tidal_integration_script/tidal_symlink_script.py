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
import sys
import termios
import tty
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
DEFAULT_PROJECT_DIR = None
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
            formatted_path = path # os.path.join(path, "*")
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
    Returns the folder name if a symlink was created, None otherwise
    """
    # Skip directories
    if os.path.isdir(src_path):
        return None
    
    # Check if the file is an audio file
    if not src_path.lower().endswith(AUDIO_EXTENSIONS):
        return None
    
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
            
            # Return the folder name for reloading
            return folder_name
            
        except Exception as e:
            logging.error(f"Error creating symlink: {e}")
    else:
        logging.debug(f"File {file_name} does not match the required pattern")
    
    return None

def process_existing_files():
    """
    Process all existing files in the SAMPLES_DIR
    """
    # Ensure we're using absolute path for consistency
    samples_dir_abs = os.path.abspath(SAMPLES_DIR)
    
    logging.info(f"Processing existing files in {samples_dir_abs}")
    try:
        # Keep track of modified folders
        modified_folders = set()
        
        for root, _, files in os.walk(samples_dir_abs):
            for file in files:
                src_path = os.path.join(root, file)
                folder_name = create_symlink(src_path)
                if folder_name:
                    modified_folders.add(folder_name)
        
        logging.info("Finished processing existing files")
        
        # Send OSC message to load samples for each modified folder
        for folder_name in modified_folders:
            folder_path = os.path.join(os.path.abspath(TIDAL_SAMPLES_DIR), folder_name)
            send_osc_load_samples(folder_path)
        
    except Exception as e:
        logging.error(f"Error processing existing files: {e}")

class AudioFileHandler(FileSystemEventHandler):
    """
    Handler for file system events
    """
    def __init__(self):
        self.modified_folders = set()
        self.last_reload_time = 0
        self.reload_cooldown = 5  # seconds between sample directory reloads
    
    def on_created(self, event):
        """Handle file creation events"""
        if not event.is_directory:
            self.process_file(event.src_path)
            
    def on_modified(self, event):
        """Handle file modification events"""
        if not event.is_directory:
            self.process_file(event.src_path)
            
    def on_moved(self, event):
        """Handle file moved/renamed events"""
        if not event.is_directory:
            self.process_file(event.dest_path)
            
    def process_file(self, src_path):
        """Process a file by creating a symlink if it matches the criteria"""
        print("Processing file: ", src_path)
        folder_name = create_symlink(src_path)
        
        if folder_name:
            # Add to the set of modified folders
            self.modified_folders.add(folder_name)
            # Schedule a reload
            self.schedule_reload()
        
    def schedule_reload(self):
        """Schedule a reload of modified folders after cooldown period"""
        current_time = time.time()
        if current_time - self.last_reload_time > self.reload_cooldown:
            self.reload_modified_folders()
            
    def reload_modified_folders(self):
        """Reload only the modified folders"""
        if not self.modified_folders:
            return
            
        self.last_reload_time = time.time()
        
        # Send OSC message to reload each modified folder
        for folder_name in self.modified_folders:
            folder_path = os.path.join(os.path.abspath(TIDAL_SAMPLES_DIR), folder_name)
            send_osc_load_samples(folder_path)
            logging.info(f"Triggered sample reload for folder: {folder_name}")
            
        # Clear the set of modified folders
        self.modified_folders.clear()

def reload_all_files():
    """Reload all files in the tidalSamples directory"""
    logging.info("Reloading all files...")
    for root, dirs, _ in os.walk(TIDAL_SAMPLES_DIR):
        for dir_name in dirs:
            if dir_name.startswith('t_'):
                folder_path = os.path.join(root, dir_name)
                send_osc_load_samples(folder_path)
                logging.info(f"Reloaded samples in {dir_name}")

def relink_all_files():
    """Remove and recreate all symbolic links"""
    logging.info("Relinking entire tidalSamples directory...")
    
    # Remove existing tidalSamples directory
    if os.path.exists(TIDAL_SAMPLES_DIR):
        shutil.rmtree(TIDAL_SAMPLES_DIR)
    
    # Recreate directory and process all files
    os.makedirs(TIDAL_SAMPLES_DIR, exist_ok=True)
    process_existing_files()
    logging.info("Completed relinking all files")

def get_char():
    """Get a single character from standard input"""
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(sys.stdin.fileno())
        ch = sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    return ch

def main():
    """Main function to set up and start the file system observer"""
    # Parse command line arguments
    parser = argparse.ArgumentParser(description='Monitor a directory for Tidal sample files and create symbolic links.')
    parser.add_argument('--project-dir', '-p', dest='project_dir', default=DEFAULT_PROJECT_DIR,
                        help=f'Project directory to monitor (default: {DEFAULT_PROJECT_DIR})')
    parser.add_argument('--samples-dir', '-s', dest='samples_dir', default=DEFAULT_SAMPLES_DIR,
                        help=f'Source directory to monitor (default: {DEFAULT_SAMPLES_DIR})')
    parser.add_argument('--tidal-dir', '-t', dest='tidal_dir', default=DEFAULT_TIDAL_SAMPLES_DIR,
                        help=f'Target directory for symbolic links (default: {DEFAULT_TIDAL_SAMPLES_DIR})')
    args = parser.parse_args()
    
    # Set the global variables based on command line arguments and convert to absolute paths
    global SAMPLES_DIR, TIDAL_SAMPLES_DIR, PROJECT_DIR, osc_client
    SAMPLES_DIR = os.path.abspath(args.samples_dir)
    TIDAL_SAMPLES_DIR = os.path.abspath(args.tidal_dir)
    PROJECT_DIR = os.path.abspath(args.project_dir)

    if PROJECT_DIR:
        SAMPLES_DIR = os.path.join(PROJECT_DIR, 'Samples/Processed/Consolidate/')

    # Initialize OSC client
    try:
        osc_client = udp_client.SimpleUDPClient(OSC_IP, OSC_PORT)
        logging.info(f"OSC client initialized to send to {OSC_IP}:{OSC_PORT}")
    except Exception as e:
        logging.error(f"Failed to initialize OSC client: {e}")
        osc_client = None
    
    logging.info(f"Monitoring directory: {SAMPLES_DIR}")
    logging.info(f"Creating symlinks in: {TIDAL_SAMPLES_DIR}")
    logging.info(f"Project directory: {PROJECT_DIR}")

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
        logging.info("Press 'r' to reload all files, 'R' to relink entire directory, or 'q' to quit")
        while True:
            # Non-blocking keyboard input check
            if sys.stdin.isatty():  # Only try to read keyboard if we're in a terminal
                char = get_char()
                if char == 'r':
                    reload_all_files()
                elif char == 'R':
                    relink_all_files()
                elif char == 'q':
                    raise KeyboardInterrupt
            time.sleep(0.1)  # Small sleep to prevent CPU hogging
            
    except KeyboardInterrupt:
        # Stop the observer gracefully on keyboard interrupt
        observer.stop()
        logging.info("Monitoring stopped")
    
    observer.join()

if __name__ == "__main__":
    # Set up terminal for non-blocking input if we're in a terminal
    if sys.stdin.isatty():
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            main()
        finally:
            # Restore terminal settings
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
    else:
        main()





