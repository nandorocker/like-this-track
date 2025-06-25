#!/usr/bin/env python3
"""
Script to clear Spotify authentication cache
"""
import os
import glob

# Clear all potential cache files
cache_patterns = [
    '.spotify_cache',
    '.cache',
    '.cache-*'
]

for pattern in cache_patterns:
    for file in glob.glob(pattern):
        try:
            os.remove(file)
            print(f"Removed cache file: {file}")
        except OSError as e:
            print(f"Error removing {file}: {e}")

print("Cache clearing complete. Please run the main script again.")
