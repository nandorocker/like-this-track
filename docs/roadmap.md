# Like This Track - Roadmap

This document outlines the planned improvements for the "Like This Track" Alfred workflow. Each item includes a description, priority, and status.

## Roadmap Overview

### Legend
- **Priority**: High, Medium, Low
- **Status**: To Do, In Progress, Done

---

## Features & Improvements

### 1. Hotkey Support
- **Description**: Add a global hotkey to trigger the like/unlike action.
- **Priority**: High
- **Status**: To Do
- **Notes**: Use Alfred's built-in hotkey configuration. Document setup in the README.
- **Subtasks**:
  - [ ] Add hotkey trigger in Alfred workflow editor.
  - [ ] Test hotkey functionality.
  - [ ] Update README with hotkey setup instructions.

---

### 2. Show Status on Launch
- **Description**: Display Spotify playback status and track like status when the workflow is triggered.
- **Priority**: High
- **Status**: To Do
- **Notes**: Use Alfred's feedback system or script filter for richer output.
- **Subtasks**:
  - [ ] Detect Spotify playback status.
  - [ ] Display track name and artist.
  - [ ] Show like/unlike status.
  - [ ] Handle errors (e.g., Spotify not running).

---

### 3. Copy Track/Band/URL
- **Description**: Add options to copy track name, artist name, or Spotify URL after liking/unliking.
- **Priority**: Medium
- **Status**: To Do
- **Notes**: Use Alfred's "Copy to Clipboard" action or modifier keys.
- **Subtasks**:
  - [ ] Add "Copy to Clipboard" action for track name.
  - [ ] Add "Copy to Clipboard" action for artist name.
  - [ ] Add "Copy to Clipboard" action for Spotify URL.
  - [ ] Test modifier keys for alternate actions.

---

### 4. Like and Add to Playlist
- **Description**: Allow users to like a track and add it to a playlist simultaneously.
- **Priority**: Medium
- **Status**: To Do
- **Notes**: Use Spotipy's playlist API. Expose playlist selection via Alfred variables or script filter.
- **Subtasks**:
  - [ ] Implement Spotipy playlist API integration.
  - [ ] Add Alfred variable for playlist selection.
  - [ ] Test liking and adding to playlist functionality.

---

### 5. Workflow Update Checker
- **Description**: Notify users when a new version of the workflow is available.
- **Priority**: Low
- **Status**: To Do
- **Notes**: Requires hosting version info (e.g., GitHub) and a script to check it.
- **Subtasks**:
  - [ ] Host version info on GitHub.
  - [ ] Write script to check for updates.
  - [ ] Notify users via Alfred feedback.

---

## Workflow Configuration
- **Description**: Add user-configurable options for actions like "also add to playlist" or "copy info."
- **Priority**: Medium
- **Status**: To Do
- **Notes**: Use Alfred's built-in configuration panel.
- **Subtasks**:
  - [ ] Add configuration panel in Alfred.
  - [ ] Implement logic for configurable actions.
  - [ ] Test configuration options.

---

## Maintenance Notes
- Keep this file updated as features progress.
- Use Git commits to track changes to the roadmap.
- Consider breaking larger tasks into smaller tickets if needed.

---

### Example Workflow
If a feature requires more detailed planning, you can break it into subtasks:
```markdown
### 2. Show Status on Launch
- [ ] Detect Spotify playback status
- [ ] Display track name and artist
- [ ] Show like/unlike status
- [ ] Handle errors (e.g., Spotify not running)
```
