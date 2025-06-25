import os
import spotipy
from spotipy.oauth2 import SpotifyOAuth
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Scope needed to modify and read the "Liked Songs" playlist
SCOPE = 'user-library-modify user-read-playback-state user-library-read'

sp = spotipy.Spotify(auth_manager=SpotifyOAuth(client_id=os.getenv('CLIENT_ID'),
                                               client_secret=os.getenv('CLIENT_SECRET'),
                                               redirect_uri=os.getenv('REDIRECT_URI'),
                                               scope=SCOPE))

# Get the current playback information
current_track = sp.current_playback()

if current_track and current_track['is_playing']:
    track_id = current_track['item']['id']
    track_name = current_track['item']['name']
    artist_name = current_track['item']['artists'][0]['name']
    
    # Check if the track is already liked
    is_liked = sp.current_user_saved_tracks_contains([track_id])[0]
    
    if is_liked:
        # Track is already liked, so unlike it
        sp.current_user_saved_tracks_delete([track_id])
        print(f"Unliked: {artist_name} - \"{track_name}\"")
    else:
        # Track is not liked, so like it
        sp.current_user_saved_tracks_add([track_id])
        print(f"Liked: {artist_name} - \"{track_name}\"")
else:
    print("No track is currently playing.")
