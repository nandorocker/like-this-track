#!/bin/bash

# Navigate to the directory where the script is located
cd "$(dirname "$0")"

# Activate the virtual environment
source venv/bin/activate

# Run the Python script
python3 like_this_track.py
