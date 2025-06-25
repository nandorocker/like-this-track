# Like This Track - Spotify Alfred Workflow

An Alfred workflow that allows you to quickly like or unlike the currently playing track on Spotify with a simple keyboard shortcut or Alfred command.

## Features

- **Smart Toggle**: Automatically likes or unlikes the currently playing track based on its current status
- **Visual Feedback**: Shows track and artist information with action confirmation
- **Seamless Authentication**: Automatic OAuth flow with Spotify
- **Alfred Integration**: Clean workflow integration with customizable hotkeys
- **Real-time Status**: Works with any currently playing Spotify track

## Prerequisites

- macOS with Alfred 4+ (with Powerpack license)
- Active Spotify account
- Python 3.9+ installed on your system
- Spotify Developer App credentials

## Quick Start

### 1. Spotify Developer Setup

1. Visit the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Create a new app or select an existing one
3. Copy your `Client ID` and `Client Secret`
4. In app settings, add `http://localhost:8080/callback` as a redirect URI

### 2. Project Setup

```bash
# Clone the repository
git clone <repository-url>
cd like-this-track

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r src/requirements.txt
```

### 3. Configuration

Create a `.env` file in the project root:

```bash
cat > .env << EOF
CLIENT_ID=your_spotify_client_id_here
CLIENT_SECRET=your_spotify_client_secret_here
REDIRECT_URI=http://localhost:8080/callback
EOF
```

### 4. Installation

**For Development:**
```bash
# Create symlink for live development
ALFRED_WORKFLOWS_DIR="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows"
ln -sf "$(pwd)/src" "$ALFRED_WORKFLOWS_DIR/like-this-track_dev"
```

**For Production:**
```bash
# Copy to Alfred workflows directory
cp -r src "$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/like-this-track"
```

## Usage

1. **Open Alfred**: Press `⌘ + Space`
2. **Run Command**: Type `like` or use your configured hotkey
3. **Instant Action**: The workflow toggles the like status of the current track
4. **Feedback**: Receive notification with track info and action taken

## Development

### Testing

```bash
# Activate environment
source venv/bin/activate

# Test environment configuration
python src/debug_env.py

# Test main functionality (requires active Spotify playback)
python src/like-this-track.py

# Clear authentication cache if needed
python src/clear_cache.py
```

### Project Structure

```
like-this-track/
├── README.md                 # Project documentation
├── .env                      # Environment variables (create this)
├── src/                      # Alfred workflow source files
│   ├── like-this-track.py   # Main workflow script
│   ├── debug_env.py         # Environment debugging utility
│   ├── clear_cache.py       # Authentication cache management
│   ├── requirements.txt     # Python dependencies
│   ├── info.plist          # Alfred workflow configuration
│   └── icon.png            # Workflow icon and assets
├── venv/                    # Python virtual environment (auto-created)
└── tests/                   # Test files directory
```

## Configuration Options

The workflow uses these environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `CLIENT_ID` | Spotify app client ID | Required |
| `CLIENT_SECRET` | Spotify app client secret | Required |
| `REDIRECT_URI` | OAuth callback URL | `http://localhost:8080/callback` |

## Troubleshooting

### Authentication Issues

**Problem**: "Spotify authentication failed"
```bash
# Solution: Clear cache and re-authenticate
python src/clear_cache.py
python src/debug_env.py
```

**Problem**: "Invalid client credentials"
- Verify `CLIENT_ID` and `CLIENT_SECRET` in `.env` file
- Ensure redirect URI matches Spotify app settings exactly

### Environment Issues

**Problem**: "No module named 'spotipy'"
```bash
# Solution: Ensure virtual environment is activated
source venv/bin/activate
pip install -r src/requirements.txt
```

**Problem**: Python path issues in Alfred
- Check that the virtual environment path in the script matches your Python version
- Verify Alfred has permissions to execute the script

### Playback Issues

**Problem**: "No track currently playing"
- Ensure Spotify is actively playing music (not paused)
- Verify Spotify is the active audio source
- Check that Spotify app is running and logged in

### Debug Tools

Use the included utilities for troubleshooting:

```bash
# Check environment and authentication
python src/debug_env.py

# Clear authentication cache
python src/clear_cache.py
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly with the debug tools
5. Submit a pull request

## License

This project is open source. Please check the repository for license details.

## Support

For issues and questions:
1. Check the troubleshooting section above
2. Run the debug tools to identify the problem
3. Open an issue on the repository with debug output