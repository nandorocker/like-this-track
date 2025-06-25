import os
import sys
import spotipy
from spotipy.oauth2 import SpotifyOAuth
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Check if required environment variables are set
required_vars = ['CLIENT_ID', 'CLIENT_SECRET', 'REDIRECT_URI']
for var in required_vars:
    if not os.getenv(var):
        print(f"Error: {var} not found in environment variables")
        sys.exit(1)

# Scope needed to modify and read the "Liked Songs" playlist
SCOPE = 'user-library-modify user-read-playback-state user-library-read'

# Create auth manager with proper cache handling
auth_manager = SpotifyOAuth(
    client_id=os.getenv('CLIENT_ID'),
    client_secret=os.getenv('CLIENT_SECRET'),
    redirect_uri=os.getenv('REDIRECT_URI'),
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
            if not verification[0]:
                print(f"Unliked: {artist_name} - \"{track_name}\"")
            else:
                print(f"Failed to unlike: {artist_name} - \"{track_name}\"")
        else:
            # Track is not liked, so like it
            sp.current_user_saved_tracks_add([track_id])
            # Verify the operation
            verification = sp.current_user_saved_tracks_contains([track_id])
            if verification[0]:
                print(f"Liked: {artist_name} - \"{track_name}\"")
            else:
                print(f"Failed to like: {artist_name} - \"{track_name}\"")
    except Exception as e:
        print(f"Error updating track like status: {e}")
        sys.exit(1)
else:
    print("No track is currently playing.")
