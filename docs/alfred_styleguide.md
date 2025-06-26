## Gallery Workflow Style Guide

The Alfred Gallery strives for predictability between workflow READMEs so users have an easier time navigating and picking up new workflows. While exceptions are inevitable, this document covers how to remain consistent in common situations.

*Note: Certain terms, such as `Universal Action` and `Hotkey`, become automatic links to Alfred's documentation when rendered in the Gallery.*

## Index

- [Introduction](https://alfred.app/submit/styleguide/#introduction)
- [Universal Actions](https://alfred.app/submit/styleguide/#universal-actions)
- [Screenshots](https://alfred.app/submit/styleguide/#screenshots)
- [Modifiers](https://alfred.app/submit/styleguide/#modifiers)
- [Alternative Invocations](https://alfred.app/submit/styleguide/#alternative-invocations)
- [Hotkeys](https://alfred.app/submit/styleguide/#hotkeys)
- [Workflow Configuration](https://alfred.app/submit/styleguide/#workflow-configuration)
- [Setup](https://alfred.app/submit/styleguide/#setup)

## Introduction

Start with `## Usage` and one or two short sentences describing the main action on the workflow. `Search` is a great way to begin if the action involves any type of filtering through results.

End with ``via the `INPUT` keyword``. Use `keyword` even if referring to a Script Filter, File Filter, or similar. Occasional use of `with` instead of `via` helps to mix it up.

- **Window Switcher** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/window-switcher/)
	```markdown
	## Usage
	    
	    Search app windows in the current Desktop Space via the \`win\` keyword.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/window-switcher/)
	![Window Switcher intro example](https://alfred.app/media/guides/styleguide/intro-window-switcher.png)
- **Disk Usage** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/disk-usage/)
	```markdown
	## Usage
	    
	    See how much storage is being used by internal and external disks via the \`storage\` keyword.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/disk-usage/)
	![Disk Usage intro example](https://alfred.app/media/guides/styleguide/intro-disk-usage.png)

## Universal Actions

When describing a Universal Action, end with `via the Universal Action`. Use `Universal Action` even if referring to a File Action.

- **Share with AirDrop** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/share-with-airdrop/)
	```markdown
	## Usage
	    
	    Send files, text, and URLs with AirDrop via the Universal Action.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/share-with-airdrop/)
	![Share with AirDrop Universal Action example](https://alfred.app/media/guides/styleguide/ua-share-with-airdrop.png)
- **HEIC to JPEG** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/heic-to-jpeg/)
	```markdown
	## Usage
	    
	    Convert HEIC images to JPEG via the Universal Action.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/heic-to-jpeg/)
	![HEIC to JPEG Universal Action example](https://alfred.app/media/guides/styleguide/ua-heic-to-jpeg.png)

## Screenshots

Continue with an image directly illustrating the text. See [Taking Good Screenshots](https://alfred.app/submit/screenshots/).

Use standard markdown syntax for images: `![ALT TEXT](images/SOMETHING.png)`.

- **Mount Disks** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/mount-disks/)
	```markdown
	## Usage
	    
	    Mount disk partitions via the \`mount\` keyword.
	    
	    ![Showing disk partitions to mount](images/mount.png)
	```
	[Live Version](https://alfred.app/workflows/alfredapp/mount-disks/)
	![Mount Disks screenshot example](https://alfred.app/media/guides/styleguide/screenshot-mount-disks.png)
- **Send to Current Folder** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/send-to-current-folder/)
	```markdown
	## Usage
	    
	    Move or copy files to the frontmost Finder window via the Universal Actions.
	    
	    ![Universal actions to move and copy](images/ua.png)
	```
	[Live Version](https://alfred.app/workflows/alfredapp/send-to-current-folder/)
	![Send to Current Folder screenshot example](https://alfred.app/media/guides/styleguide/screenshot-send-to-current-folder.png)

## Modifiers

List modifiers below the image in a list of the format `* KEYS ACTION`. Use ↩︎⌘⌥⌃⇧ for the keys, surrounding each character in the `<kbd>` HTML tag.

For previewing with Quick Look, use `* <kbd>⌘</kbd><kbd>Y</kbd> Quick Look SOMETHING`.

- **Notes** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/notes/)
	```markdown
	![Searching notes](images/search.png)
	    
	    * <kbd>↩</kbd> Open note in the Notes app.
	    * <kbd>⌃</kbd><kbd>↩</kbd> Delete note.
	    * <kbd>⌘</kbd><kbd>⌥</kbd><kbd>⌃</kbd><kbd>↩</kbd> Force cache flush.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/notes/)
	![Notes modifers example](https://alfred.app/media/guides/styleguide/modifiers-notes.png)
- **Alfred Gallery** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/alfred-gallery/)
	```markdown
	![Searching for alfredapp workflows](images/gallery.png)
	    
	    * <kbd>↩</kbd> Open Gallery page in default browser.
	    * <kbd>⌃</kbd> Show tags.
	    * <kbd>⌘</kbd><kbd>↩</kbd> Install workflow.
	    * <kbd>⌥</kbd><kbd>↩</kbd> Narrow search to creator’s name.
	    * <kbd>⌘</kbd><kbd>Y</kbd> Quick Look workflow’s Gallery page.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/alfred-gallery/)
	![Alfred gallery modifers example](https://alfred.app/media/guides/styleguide/modifiers-alfred-gallery.png)

## Alternative Invocations

If there is both a keyword and Universal Action for the same task, use `Alternatively,` and another screenshot.

- **Ignore in Alfred** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/ignore-in-alfred/)
	```markdown
	Alternatively, search for files and folders via the \`ignore\`, \`unignore\`, and \`reignore\` keywords.
	    
	    ![Alfred search for ignore](images/ignore.png)
	```
	[Live Version](https://alfred.app/workflows/alfredapp/ignore-in-alfred/)
	![Ignore in Alfred alternatively example](https://alfred.app/media/guides/styleguide/alternatively-ignore-in-alfred.png)
- **Thumbnail Navigation** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/thumbnail-navigation/)
	```markdown
	Alternatively, begin navigation in a folder via the Universal Action.
	    
	    ![Navigate with Universal Action](images/navua.png)
	```
	[Live Version](https://alfred.app/workflows/alfredapp/thumbnail-navigation/)
	![Thumbnail Navigation alternatively example](https://alfred.app/media/guides/styleguide/alternatively-thumbnail-navigation.png)

## Hotkeys

Mention Hotkeys with `Configure the Hotkey SOMETHING`.

- **Banner be Gone** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/banner-be-gone/)
	```markdown
	Configure the Hotkey for faster triggering.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/banner-be-gone/)
	![Banner be Gone Hotkey example](https://alfred.app/media/guides/styleguide/hotkey-banner-be-gone.png)
- **Unit Converter** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/unit-converter/)
	```markdown
	Configure the Hotkey or use the Universal Action as shortcuts to convert results from Alfred’s Calculator, Clipboard History, or selected text.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/unit-converter/)
	![Unit Converter Hotkey example](https://alfred.app/media/guides/styleguide/hotkey-unit-converter.png)

## Workflow Configuration

Configuration should be explained in the workflow itself, but it is OK to mention the occasional relevant option users might otherwise miss. Describe it with `Workflow’s Configuration`.

- **Network Quality** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/network-quality/)
	```markdown
	Analysis takes a few seconds to complete. Results are copied to the clipboard and displayed in the viewer defined in the Workflow’s Configuration.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/network-quality/)
	![Network Quality workflow configuration example](https://alfred.app/media/guides/styleguide/configuration-network-quality.png)
- **Backup Preferences** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/backup-preferences/)
	```markdown
	Generate a backup of your local Alfred Preferences via the \`start backup\` keyword. A macOS launchd agent will be loaded to do it daily at the time set in the Workflow’s Configuration (using the [24-hour clock format](https://en.wikipedia.org/wiki/24-hour_clock)). The number of versions to keep is likewise configurable.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/backup-preferences/)
	![Backup Preferences workflow configuration example](https://alfred.app/media/guides/styleguide/configuration-backup-preferences.png)

## Setup

Add `## Setup` above the Usage section if extra manual steps are required before using the workflow. Leave out required Configuration items because Alfred itself warns of those. Leave out installing apps, Homebrew formulae, or setting API keys because the Gallery mentions those in a separate section.

- **Pause Tabs** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/pause-tabs/)
	```markdown
	## Setup
	    
	    Turn on \`Allow JavaScript from Apple Events\` in the browsers you want to control. The exact location of the option depends on the browser.
	```
	[Live Version](https://alfred.app/workflows/alfredapp/pause-tabs/)
	![Pause Tabs setup example](https://alfred.app/media/guides/styleguide/setup-pause-tabs.png)
- **1Password** Example
	[Markdown Source](https://github.com/alfredapp/gallery-edits/tree/main/workflows/alfredapp/1password/)
	```markdown
	## Setup
	    
	    [Install the 1Password CLI](https://1password.com/downloads/command-line/) and turn on the integration in 1Password Preferences → Developer → Connect with 1Password CLI.
	    
	    ![1Password preferences](images/1password_preferences.png)
	```
	[Live Version](https://alfred.app/workflows/alfredapp/1password/)
	![1Password setup example](https://alfred.app/media/guides/styleguide/setup-1password.png)