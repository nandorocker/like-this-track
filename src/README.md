# 🎵 Like This Track - Alfred Workflow

Instantly like or unlike the currently playing song on Spotify with a simple Alfred command.

## 🚀 Installation

1. **Create a Spotify App**
   - Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
   - Click "Create an App"
   - Add `http://localhost:8888/callback` as a Redirect URI

2. **Install & Configure the Workflow**
   - Download & run the `like-this-track.workflow` file
   - Enter your `CLIENT_ID` and `CLIENT_SECRET` from step 1
   - Press "Install"

3. **First Run**
   - Type `likeit` in Alfred
   - Your browser will open for Spotify authorization
   - Grant permissions and you're ready to go!

## 💡 Usage

Type `likeit` in Alfred to toggle like status of the currently playing track.

- If the track isn't liked → it gets added to your Liked Songs
- If the track is already liked → it gets removed from your Liked Songs

## 🔧 Troubleshooting

**"Missing Credentials" error**
- Make sure you've configured `CLIENT_ID` and `CLIENT_SECRET` in the workflow settings

**"Error authenticating" message**
- Verify your Client ID and Secret are correct
- Check that `http://localhost:8888/callback` is added to your Spotify app's Redirect URIs

**"No Track Playing" message**
- Make sure Spotify is open and playing a track
- The track must be actively playing (not paused)

**Authorization issues**
- Delete the `.spotify_cache` file in the workflow directory and try again
- Re-authorize by running `likeit` again

## Credits
- Workflow by [Nando Rossi](https://nan.do) & [Robots]([https://](https://github.com/features/copilot))