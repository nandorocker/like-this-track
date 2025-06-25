#!/bin/bash

# Like This Track - Spotify Alfred Workflow Build Script
# Builds distributable Alfred workflow package

set -e  # Exit on any error

# Configuration
PROJECT_NAME="like_this_track"
WORKFLOW_NAME="Like This Track"
BUNDLE_ID="net.nandorocker.spotifyLikeThis"
PYTHON_MIN_VERSION="3.9"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
VENV_DIR="$SCRIPT_DIR/venv"
BUILD_DIR="$SCRIPT_DIR/build"
DIST_DIR="$SCRIPT_DIR/dist"

# Utility functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_python_version() {
    if ! command -v python3 &> /dev/null; then
        log_error "Python 3 is not installed"
        exit 1
    fi
    
    local python_version=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    local required_version="$PYTHON_MIN_VERSION"
    
    if ! python3 -c "import sys; exit(0 if sys.version_info >= tuple(map(int, '$required_version'.split('.'))) else 1)"; then
        log_error "Python $required_version or higher is required. Found: $python_version"
        exit 1
    fi
    
    log_success "Python version $python_version is compatible"
}

check_venv() {
    if [ ! -d "$VENV_DIR" ]; then
        log_error "Virtual environment not found at $VENV_DIR"
        log_error "Please create and set up your virtual environment first:"
        log_error "  python3 -m venv venv"
        log_error "  source venv/bin/activate"
        log_error "  pip install -r src/requirements.txt"
        exit 1
    fi
    
    if [ ! -f "$VENV_DIR/bin/activate" ]; then
        log_error "Virtual environment appears to be corrupted"
        exit 1
    fi
}

validate_build_requirements() {
    log_info "Validating build requirements..."
    
    # Check for required source files
    local required_files=("like_this_track.py" "info.plist" "icon.png" "requirements.txt")
    for file in "${required_files[@]}"; do
        if [ ! -f "$SRC_DIR/$file" ]; then
            log_error "Required file missing: $SRC_DIR/$file"
            exit 1
        fi
    done
    
    # Activate virtual environment and check dependencies
    source "$VENV_DIR/bin/activate"
    
    # Test main script syntax
    log_info "Validating main script syntax..."
    if ! python3 -m py_compile "$SRC_DIR/like_this_track.py"; then
        log_error "Main script has syntax errors"
        exit 1
    fi
    
    # Check if required packages are installed
    local required_packages=("spotipy" "dotenv")
    for package in "${required_packages[@]}"; do
        if ! python3 -c "import $package" 2>/dev/null; then
            log_error "Required package not installed: $package"
            log_error "Install dependencies with: pip install -r src/requirements.txt"
            exit 1
        fi
    done
    
    log_success "Build requirements validated"
}

create_package() {
    log_info "Creating workflow package..."
    
    # Create build and dist directories
    mkdir -p "$BUILD_DIR" "$DIST_DIR"
    
    # Clean previous build
    rm -rf "$BUILD_DIR"/*
    
    # Copy source files to build directory
    cp -r "$SRC_DIR"/* "$BUILD_DIR/"
    
    # Activate virtual environment to get the right packages
    source "$VENV_DIR/bin/activate"
    
    # Bundle Python dependencies
    log_info "Bundling Python dependencies..."
    local site_packages=$(python3 -c "import site; print(site.getsitepackages()[0])")
    
    # Create a lib directory in build
    mkdir -p "$BUILD_DIR/lib"
    
    # Copy required packages
    local packages=("spotipy" "dotenv" "requests" "urllib3" "certifi" "charset_normalizer" "idna")
    for package in "${packages[@]}"; do
        if [ -d "$site_packages/$package" ]; then
            cp -r "$site_packages/$package" "$BUILD_DIR/lib/"
            log_info "Bundled package: $package"
        elif [ -f "$site_packages/${package}.py" ]; then
            cp "$site_packages/${package}.py" "$BUILD_DIR/lib/"
            log_info "Bundled module: $package"
        fi
    done
    
    # Also copy any .dist-info directories for the packages
    for package in "${packages[@]}"; do
        for dist_info in "$site_packages"/${package}*.dist-info; do
            if [ -d "$dist_info" ]; then
                cp -r "$dist_info" "$BUILD_DIR/lib/"
            fi
        done
    done
    
    # Update the main script to use bundled dependencies
    log_info "Updating script to use bundled dependencies..."
    
    # Create a modified version of the main script that looks for bundled libs first
    cat > "$BUILD_DIR/like_this_track.py" << 'EOF'
import os
import sys

# Add bundled libraries to path first
script_dir = os.path.dirname(os.path.abspath(__file__))
lib_dir = os.path.join(script_dir, 'lib')
if os.path.exists(lib_dir):
    sys.path.insert(0, lib_dir)

# Add the project root and venv site-packages to Python path for Alfred compatibility
project_root = os.path.dirname(script_dir)
venv_site_packages = os.path.join(project_root, 'venv', 'lib', 'python3.11', 'site-packages')

# Add paths if they exist
if os.path.exists(venv_site_packages):
    sys.path.insert(0, venv_site_packages)

# Also check for other common Python versions
for version in ['3.12', '3.10', '3.9']:
    alt_path = os.path.join(project_root, 'venv', 'lib', f'python{version}', 'site-packages')
    if os.path.exists(alt_path):
        sys.path.insert(0, alt_path)
        break

try:
    import spotipy
    from spotipy.oauth2 import SpotifyOAuth
    from dotenv import load_dotenv
except ImportError as e:
    print(f"Error importing required modules: {e}")
    print("Please ensure spotipy and python-dotenv are installed:")
    print("pip install spotipy python-dotenv")
    print(f"Current Python path: {sys.path}")
    print(f"Looking for packages in: {lib_dir}")
    sys.exit(1)

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
    cache_path=os.path.join(script_dir, '.spotify_cache')
)

def get_current_track():
    """Get the currently playing track from Spotify."""
    try:
        sp = spotipy.Spotify(auth_manager=auth_manager)
        current_track = sp.current_playback()
        
        if current_track is None or not current_track.get('is_playing'):
            return None, "No track is currently playing"
        
        track = current_track.get('item')
        if track is None:
            return None, "No track information available"
        
        return track, None
    except Exception as e:
        return None, f"Error getting current track: {str(e)}"

def is_track_saved(track_id):
    """Check if a track is saved in the user's library."""
    try:
        sp = spotipy.Spotify(auth_manager=auth_manager)
        results = sp.current_user_saved_tracks_contains([track_id])
        return results[0] if results else False
    except Exception as e:
        print(f"Error checking if track is saved: {e}")
        return False

def toggle_track_like(track_id, is_saved):
    """Toggle the like status of a track."""
    try:
        sp = spotipy.Spotify(auth_manager=auth_manager)
        
        if is_saved:
            # Unlike the track
            sp.current_user_saved_tracks_delete([track_id])
            return "unliked"
        else:
            # Like the track
            sp.current_user_saved_tracks_add([track_id])
            return "liked"
    except Exception as e:
        print(f"Error toggling track like: {e}")
        return None

def main():
    """Main function to toggle like status of currently playing track."""
    # Get current track
    track, error = get_current_track()
    if error:
        print(error)
        return
    
    track_id = track['id']
    track_name = track['name']
    artist_names = ', '.join([artist['name'] for artist in track['artists']])
    
    # Check if track is already saved
    is_saved = is_track_saved(track_id)
    
    # Toggle like status
    action = toggle_track_like(track_id, is_saved)
    
    if action:
        status = "❤️" if action == "liked" else "💔"
        print(f"{status} {track_name} by {artist_names} - {action}")
    else:
        print(f"Failed to toggle like status for: {track_name} by {artist_names}")

if __name__ == "__main__":
    main()
EOF
    
    # Create the Alfred workflow package
    local workflow_file="$DIST_DIR/${PROJECT_NAME}.alfredworkflow"
    log_info "Creating Alfred workflow file: $workflow_file"
    
    # Create zip file with .alfredworkflow extension
    cd "$BUILD_DIR"
    zip -r "$workflow_file" .
    cd "$SCRIPT_DIR"
    
    log_success "Workflow package created: $workflow_file"
    log_info "Package size: $(du -h "$workflow_file" | cut -f1)"
}

clean_build() {
    log_info "Cleaning build artifacts..."
    
    # Remove build directories
    rm -rf "$BUILD_DIR" "$DIST_DIR"
    
    # Clean Python cache in build area only
    find "$SCRIPT_DIR" -path "./build" -prune -o -path "./dist" -prune -o -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    find "$SCRIPT_DIR" -path "./build" -prune -o -path "./dist" -prune -o -type f -name "*.pyc" -delete 2>/dev/null || true
    
    log_success "Build cleanup completed"
}

do_full_build() {
    log_info "Starting complete build process..."
    check_python_version
    check_venv
    validate_build_requirements
    
    # Clean first
    if [ -d "$BUILD_DIR" ] || [ -d "$DIST_DIR" ]; then
        log_info "Cleaning previous build artifacts..."
        rm -rf "$BUILD_DIR" "$DIST_DIR"
    fi
    
    # Then build
    create_package
    
    # Clean up build directory after successful package creation
    log_info "Cleaning up temporary build files..."
    rm -rf "$BUILD_DIR"
    
    log_success "Complete build process finished!"
    log_info "Final package: $DIST_DIR/${PROJECT_NAME}.alfredworkflow"
}

show_help() {
    echo "Like This Track - Build Script"
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Default behavior (no arguments):"
    echo "  Performs complete build: clean + validate + build workflow package"
    echo ""
    echo "Commands:"
    echo "  build     Build the Alfred workflow package only"
    echo "  clean     Clean build artifacts only"
    echo "  help      Show this help message"
    echo ""
    echo "Prerequisites:"
    echo "  - Python $PYTHON_MIN_VERSION+ with virtual environment set up"
    echo "  - Dependencies installed: pip install -r src/requirements.txt"
    echo ""
    echo "Examples:"
    echo "  $0           # Complete build process (recommended)"
    echo "  $0 build     # Build workflow package only"
    echo "  $0 clean     # Clean build artifacts only"
}

# Main script logic
case "${1:-}" in
    "")
        do_full_build
        ;;
        build)
        log_info "Building Alfred workflow package..."
        check_python_version
        check_venv
        validate_build_requirements
        create_package
        log_success "Build completed successfully!"
        ;;
    clean)
        clean_build
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        log_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac