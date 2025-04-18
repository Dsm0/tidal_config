#!/usr/bin/env python3


# OSC settings
OSC_IP = "127.0.0.1"  # localhost
OSC_PORT = 57209      # port to send OSC messages to

        
from pythonosc import udp_client
        
        
        

def main():
    """Main function to set up and start the file system observer"""
    # Parse command line arguments
    osc_client = udp_client.SimpleUDPClient(OSC_IP, OSC_PORT)
    osc_client.send_message("/tidal/initNodeTree", None)
    

if __name__ == "__main__":
    main()