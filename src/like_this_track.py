import os
import sys

# Add the project root and venv site-packages to Python path for Alfred compatibility
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(script_dir)

# Check if we're in development environment
dev_env_path = os.path.join(project_root, '.env')
is_dev = os.path.exists(dev_env_path)

if is_dev:
    # Development environment - use .env file
    venv_site_packages = os.path.join(project_root, 'venv', 'lib', 'python3.11', 'site-packages')
    if os.path.exists(venv_site_packages):
        sys.path.insert(0, venv_site_packages)
    
    # Check for other Python versions
    for version in ['3.12', '3.10', '3.9']:
        alt_path = os.path.join(project_root, 'venv', 'lib', f'python{version}', 'site-packages')
        if os.path.exists(alt_path):
            sys.path.insert(0, alt_path)
            break

try:
    import spotipy
    from spotipy.oauth2 import SpotifyOAuth
    if is_dev:
        from dotenv import load_dotenv
        load_dotenv(dev_env_path)
except ImportError as e:
    print(f"Error importing required modules: {e}")
    print("Please ensure spotipy is installed")
    sys.exit(1)

# Get credentials from environment (Alfred variables or .env)
client_id = os.getenv('CLIENT_ID')
client_secret = os.getenv('CLIENT_SECRET')
redirect_uri = os.getenv('REDIRECT_URI', 'http://localhost:8888/callback')

# Check if credentials are available
if not client_id or not client_secret:
    print("Missing Credentials|Please configure CLIENT_ID and CLIENT_SECRET in Alfred workflow settings")
    sys.exit(1)

# Scope needed to modify and read the "Liked Songs" playlist
SCOPE = 'user-library-modify user-read-playback-state user-library-read'

# Create auth manager with proper cache handling
auth_manager = SpotifyOAuth(
    client_id=client_id,
    client_secret=client_secret,
    redirect_uri=redirect_uri,
    scope=SCOPE,
    cache_path=".spotify_cache",
    show_dialog=False,
    open_browser=True
)

try:
    sp = spotipy.Spotify(auth_manager=auth_manager)
    # Test the connection
    sp.current_user()
except Exception as e:
    print(f"Error authenticating with Spotify: {e}")
    print("Please check your CLIENT_ID, CLIENT_SECRET, and REDIRECT_URI in the .env file")
    print("Also make sure the REDIRECT_URI is added to your Spotify app settings")
    sys.exit(1)

try:
    current_track = sp.current_playback()
except Exception as e:
    print(f"Error getting current playback: {e}")
    sys.exit(1)

if current_track and current_track['is_playing'] and current_track['item']:
    track_id = current_track['item']['id']
    track_name = current_track['item']['name']
    artist_name = current_track['item']['artists'][0]['name']
    
    # Check if the track is already liked
    try:
        is_liked_result = sp.current_user_saved_tracks_contains([track_id])
        is_liked = is_liked_result[0] if is_liked_result else False
    except Exception as e:
        print(f"Error checking if track is liked: {e}")
        sys.exit(1)
    
    try:
        if is_liked:
            # Track is already liked, so unlike it
            sp.current_user_saved_tracks_delete([track_id])
            # Verify the operation
            verification = sp.current_user_saved_tracks_contains([track_id])
            if verification and not verification[0]:
                print(f"Track Unliked!|Removed: {artist_name} - \"{track_name}\"")
            else:
                print(f"Unlike Failed!|Failed to unlike: {artist_name} - \"{track_name}\"")
        else:
            # Track is not liked, so like it
            sp.current_user_saved_tracks_add([track_id])
            # Verify the operation
            verification = sp.current_user_saved_tracks_contains([track_id])
            if verification and verification[0]:
                print(f"Track Liked!|Added: {artist_name} - \"{track_name}\"")
            else:
                print(f"Like Failed!|Failed to like: {artist_name} - \"{track_name}\"")
    except Exception as e:
        print(f"Error!|Error updating track like status: {e}")
        sys.exit(1)
else:
    print("No Track Playing|No track is currently playing.")
