# Tidal Samples Symlink Generator

This script automatically creates symbolic links for audio files in the specified source folder that match the pattern `t_{folderName}_{filename}` or `t_{folderName} {filename}`. The links are created with the directory structure `tidalSamples/{folderName}/{timestamp}_{fileName}`.

## Features

- Monitors the source folder for any changes (new files, modifications, renamed files)
- Supports two filename patterns: `t_{folderName}_{filename}` and `t_{folderName} {filename}`
- Automatically creates symbolic links in the appropriate directory structure
- Processes all existing files when started
- Uses timestamps to ensure unique filenames
- Includes `sceval()` function to communicate with SuperCollider via an existing sclang process
- Supports command line arguments to customize source and target directories
- Uses absolute paths for consistent symlink creation

## Requirements

- Python 3.6+
- watchdog library
- psutil library

## Installation

1. Clone this repository or download the script files
2. Install dependencies:

```bash
pip install -r requirements.txt
```

## Usage

1. Make sure the script has the necessary permissions:

```bash
chmod +x tidal_symlink_script.py
```

2. Run the script:

```bash
# Run with default directories
./tidal_symlink_script.py

# Specify custom directories
./tidal_symlink_script.py --samples-dir "/path/to/samples" --tidal-dir "/path/to/tidalSamples"

# Using short options
./tidal_symlink_script.py -s "/path/to/samples" -t "/path/to/tidalSamples"
```

3. The script will:
   - Create the target directory if it doesn't exist
   - Create the source directory if it doesn't exist
   - Process all existing files in the source directory
   - Begin monitoring for changes

### Filename Pattern

The script looks for audio files with the following naming patterns:
- `t_drums_kick.wav` - using underscores as separators (t_{folderName}_{filename})
- `t_drums kick.wav` - using a space after the folder name (t_{folderName} {filename})

These will create symbolic links in:
- `tidalSamples/drums/timestamp_kick.wav`

### Command Line Arguments

| Argument | Short | Description | Default |
|----------|-------|-------------|---------|
| `--samples-dir` | `-s` | Source directory to monitor | `/Samples` |
| `--tidal-dir` | `-t` | Target directory for symbolic links | `tidalSamples` |

4. To run the script in the background:

```bash
nohup ./tidal_symlink_script.py > tidal_symlink.log 2>&1 &
```

5. To stop the script, press Ctrl+C (if running in the foreground) or find and kill the process (if running in the background).

## Troubleshooting

If symlinks are not being created correctly:
- Check that both source and target paths are accessible
- Verify that you have write permissions for the target directory
- Check that files follow one of the supported naming patterns
- On Windows, make sure you're running the script with administrator privileges (required for symlinks)
- Check the log for any error messages

## Configuration

The script has several configurable variables:

- `DEFAULT_SAMPLES_DIR`: The default source directory to monitor (default: `/Samples`)
- `DEFAULT_TIDAL_SAMPLES_DIR`: The default root directory for symbolic links (default: `tidalSamples`)
- `AUDIO_EXTENSIONS`: The file extensions considered as audio files

You can modify these values directly in the script or use command line arguments to override them at runtime.

## Note

Make sure the script has appropriate permissions to access the `/Samples` directory and create files in the `tidalSamples` directory. 