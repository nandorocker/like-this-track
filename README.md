# Like This Track - Spotify Alfred Workflow

## Description

An Alfred workflow that allows you to quickly like or unlike the currently playing track on Spotify with a simple keyboard shortcut or Alfred command. The workflow intelligently toggles the like status - if the track is already liked, it will be unliked, and vice versa.

## Features

- Toggle like/unlike status for the currently playing Spotify track
- Visual feedback with track and artist information
- Automatic authentication with Spotify
- Supports both liked and unliked tracks
- Clean, efficient workflow integration with Alfred

## Prerequisites

- macOS with Alfred 4+ (with Powerpack)
- Spotify account
- Python 3.9+ installed
- Spotify Developer App (for API credentials)

## Spotify Developer Setup

1. Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Create a new app or use an existing one
3. Note down your `Client ID` and `Client Secret`
4. Add `http://localhost:8080/callback` as a redirect URI in your app settings

## Development Setup

### 1. Clone and Setup Virtual Environment

```bash
git clone <repository-url>
cd like_this_track
python3 -m venv venv
source venv/bin/activate
pip install -r src/requirements.txt
```

### 2. Environment Configuration

Create a `.env` file in the project root with your Spotify credentials:

```bash
# Create .env file
cat > .env << EOF
CLIENT_ID=your_spotify_client_id_here
CLIENT_SECRET=your_spotify_client_secret_here
REDIRECT_URI=http://localhost:8080/callback
EOF
```

### 3. Development Symlink for Alfred

To test the workflow during development, create a symlink in Alfred's workflows directory:

```bash
# Find your Alfred preferences folder (usually ~/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows)
# Replace with your actual Alfred preferences path
ALFRED_WORKFLOWS_DIR="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows"

# Create a symlink to your src folder
ln -sf "$(pwd)/src" "$ALFRED_WORKFLOWS_DIR/like_this_track_dev"
```

### 4. Testing

Test the script directly from the command line:

```bash
# Activate virtual environment
source venv/bin/activate

# Test environment setup
python src/debug_env.py

# Test the main script (make sure Spotify is playing)
python src/like_this_track.py
```

## Installation for End Users

### Method 1: Direct Installation

1. Download or clone this repository
2. Set up the virtual environment and install dependencies:

```bash
cd like_this_track
python3 -m venv venv
source venv/bin/activate
pip install -r src/requirements.txt
```

3. Create your `.env` file with Spotify credentials (see Development Setup section)

4. Copy the `src` folder to Alfred's workflows directory:

```bash
# Replace with your actual Alfred workflows path
cp -r src "$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/like_this_track"
```

### Method 2: Alfred Workflow Import (Coming Soon)

A packaged `.alfredworkflow` file will be available for easy import.

## Usage

1. Open Alfred (⌘ + Space)
2. Type `like` or use the configured hotkey
3. The workflow will like/unlike the currently playing track
4. You'll see a notification with the action taken

## Configuration

The workflow uses these environment variables:
- `CLIENT_ID`: Your Spotify app's client ID
- `CLIENT_SECRET`: Your Spotify app's client secret  
- `REDIRECT_URI`: OAuth redirect URI (should be `http://localhost:8080/callback`)

## Troubleshooting

### Common Issues

1. **"No module named 'spotipy'" error**
   - Ensure you've activated the virtual environment and installed requirements
   - Check that the virtual environment path in the script matches your Python version

2. **Authentication errors**
   - Verify your Spotify app credentials in the `.env` file
   - Ensure the redirect URI is correctly set in both `.env` and Spotify app settings

3. **"No track playing" message**
   - Make sure Spotify is actively playing a track
   - Check that Spotify is the active audio source

### Debug Tools

Use the included debug script to troubleshoot:

```bash
python src/debug_env.py
```

This will verify your environment variables and Spotify connection.

## Project Structure

```
like_this_track/
├── README.md
├── src/                  # Alfred workflow source
│   ├── like_this_track.py    # Main workflow script
│   ├── debug_env.py          # Environment debugging tool
│   ├── clear_cache.py        # Cache management utility
│   ├── requirements.txt      # Python dependencies
│   ├── info.plist           # Alfred workflow configuration
│   ├── icon.png             # Workflow icon
│   └── *.png               # Additional workflow assets
├── tests/                # Test files (empty)
└── venv/                 # Virtual environment (created during setup)
````