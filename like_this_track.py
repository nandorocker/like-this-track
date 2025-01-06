import json
import spotipy
from spotipy.oauth2 import SpotifyOAuth

# Load credentials from config.json
with open('config.json', 'r') as config_file:
    config = json.load(config_file)

# Scope needed to modify the "Liked Songs" playlist
SCOPE = 'user-library-modify user-read-playback-state'

sp = spotipy.Spotify(auth_manager=SpotifyOAuth(client_id=config['CLIENT_ID'],
                                               client_secret=config['CLIENT_SECRET'],
                                               redirect_uri=config['REDIRECT_URI'],
                                               scope='user-library-modify user-read-playback-state'))

# Get the current playback information
current_track = sp.current_playback()

if current_track and current_track['is_playing']:
    track_id = current_track['item']['id']
    sp.current_user_saved_tracks_add([track_id])
    print(f"{current_track['item']['artists'][0]['name']} - \"{current_track['item']['name']}\"")
else:
    print("No track is currently playing.")
