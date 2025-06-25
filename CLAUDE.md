# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Alfred workflow for macOS that likes the currently playing track on Spotify. The project consists of:

- A Python script (`like_this_track.py`) that uses the Spotify API via spotipy
- An Alfred workflow configuration (`info.plist`) that triggers the script
- Shell scripts for execution and notifications
- A custom notification system using the `notificator` script

## Development Setup

### Initial Setup
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Running the Script
```bash
# Direct execution
source venv/bin/activate
python3 like_this_track.py

# Via shell script wrapper
./run_spotify_liker.sh
```

## Architecture

### Core Components
- **like_this_track.py**: Main Python script that handles Spotify API authentication and track liking
- **config.json**: Contains Spotify API credentials (CLIENT_ID, CLIENT_SECRET, REDIRECT_URI)
- **run_spotify_liker.sh**: Shell wrapper that activates venv and runs the Python script
- **notificator**: Custom macOS notification script for Alfred workflows
- **info.plist**: Alfred workflow configuration defining keyword trigger "likeit" and workflow steps

### Workflow Flow
1. User types "likeit" in Alfred
2. Alfred executes the main script via shell wrapper
3. Script gets current track from Spotify API and adds it to user's liked songs
4. Success notification is displayed via notificator

### Dependencies
- **spotipy**: Python library for Spotify Web API
- **python-dotenv**: For loading environment variables from .env file
- **Alfred 4+**: Required for workflow execution
- **macOS**: Required for notification system and Alfred

## Spotify API Configuration

The script requires Spotify API credentials in a `.env` file:
- `CLIENT_ID`: Spotify app client ID
- `CLIENT_SECRET`: Spotify app client secret  
- `REDIRECT_URI`: OAuth redirect URI (typically http://localhost:8888/callback)

Create a `.env` file in the project root with:
```
CLIENT_ID=your_spotify_client_id
CLIENT_SECRET=your_spotify_client_secret
REDIRECT_URI=http://localhost:8888/callback
```

Required Spotify API scopes: `user-library-modify user-read-playback-state`

## Alfred Workflow Structure

The workflow uses keyword "likeit" and consists of two main actions:
1. Execute Python script to like current track
2. Display notification with track information

The workflow is packaged as `dist/Like This Track.alfredworkflow` for distribution.