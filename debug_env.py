#!/usr/bin/env python3
"""
Debug script to check if .env file is being read properly
"""
import os
from dotenv import load_dotenv

print("=== Debug: Environment Variables ===")

# Load environment variables from .env file
print("Loading .env file...")
load_dotenv()

# Check if required environment variables are set
required_vars = ['CLIENT_ID', 'CLIENT_SECRET', 'REDIRECT_URI']
for var in required_vars:
    value = os.getenv(var)
    if value:
        if var == 'REDIRECT_URI':
            print(f"{var}: {value}")
        else:
            # Mask sensitive data
            print(f"{var}: {value[:8]}...{value[-4:]}")
    else:
        print(f"ERROR: {var} not found!")

print("\n=== Debug: SpotifyOAuth Configuration ===")

from spotipy.oauth2 import SpotifyOAuth

# Create auth manager to see what it's actually using
auth_manager = SpotifyOAuth(
    client_id=os.getenv('CLIENT_ID'),
    client_secret=os.getenv('CLIENT_SECRET'),
    redirect_uri=os.getenv('REDIRECT_URI'),
    scope='user-library-modify user-read-playback-state user-library-read',
    cache_path=".spotify_cache",
    show_dialog=False,
    open_browser=False  # Don't open browser for debugging
)

print(f"Auth Manager Redirect URI: {auth_manager.redirect_uri}")
print(f"Auth Manager Client ID: {auth_manager.client_id[:8]}...{auth_manager.client_id[-4:]}")

# Generate auth URL to see what it looks like
auth_url = auth_manager.get_authorize_url()
print(f"\nGenerated Auth URL: {auth_url}")

# Check if the URL contains 127.0.0.1 or localhost
if "127.0.0.1" in auth_url:
    print("✅ Auth URL correctly uses 127.0.0.1")
elif "localhost" in auth_url:
    print("❌ Auth URL still uses localhost - this is the problem!")
else:
    print("⚠️  Auth URL doesn't contain expected redirect URI")
