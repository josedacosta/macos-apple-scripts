# Chrome Duplicate Window Detector for macOS

An AppleScript that detects and helps you close duplicate Chrome windows (windows with identical tabs and URLs) natively on macOS.

## Features

- 📋 Lists all open Chrome windows and their tabs
- 🔍 Detects windows with identical tabs (same URLs, same order)
- 🗑️ Interactive prompts to close duplicate windows via native macOS dialogs
- 🎯 Uses AppleScript to control Chrome directly (no external dependencies)
- 🍎 Native macOS integration with notifications

## Prerequisites

- **macOS** (any recent version)
- **Google Chrome** installed and running
- No additional software required!

## Installation

The script is ready to use. Just make sure it's executable:

```bash
chmod +x /path/to/chrome-duplicate-detector.applescript
```

## Usage

### Method 1: Direct Execution (Recommended)

```bash
osascript /path/to/chrome-duplicate-detector.applescript
```

Or if it's executable:

```bash
/path/to/chrome-duplicate-detector.applescript
```

### Method 2: Via Script Editor

1. Open **Script Editor** (Applications > Utilities > Script Editor)
2. Open the file `chrome-duplicate-detector.applescript`
3. Click the **Run** button (▶️)

### Method 3: Create an App

1. Open the script in **Script Editor**
2. Go to **File** > **Export**
3. Set **File Format** to **Application**
4. Save it (e.g., "Chrome Duplicate Detector.app")
5. Double-click the app to run it

## How It Works

### Step 1: Initial Dialog

The script shows a welcome dialog explaining what it will do.

### Step 2: Window Analysis

The script analyzes all Chrome windows and shows you:
- Total number of windows
- Each window's tabs with titles and URLs

### Step 3: Duplicate Detection

If duplicates are found, for each duplicate pair:
- Shows both the original and duplicate window side-by-side
- Asks if you want to close the duplicate
- Closes the window if you confirm

### Step 4: Completion

Shows a summary of how many duplicates were processed.

## Example Workflow

1. **Start the script**:
```bash
osascript chrome-duplicate-detector.applescript
```

2. **Welcome dialog appears** → Click "Start"

3. **All windows listed**:
```
✅ Found 3 Chrome window(s)

📋 Window 1:
   2 tab(s):
   1. GitHub - username/example-repository
      https://github.com/username/example-repository
   2. Example Search Engine
      https://www.example.com

📋 Window 2:
   2 tab(s):
   1. Example Search Engine
      https://www.example.com
   2. GitHub - username/example-repository
      https://github.com/username/example-repository

📋 Window 3:
   1 tab(s):
   1. Documentation Site
      https://docs.example.org
```

4. **Duplicate detected** → Dialog shows:
```
🔁 Duplicate Set 1 of 1

Original:
📋 Window 1: ...

⬇️  IS IDENTICAL TO  ⬇️

Duplicate:
📋 Window 2: ...
```

5. **Choose action**: Click "Close Duplicate" or "Skip"

6. **Notification**: "Window 2 closed" (if you chose to close)

7. **Done**: "✨ Done! Processed 1 duplicate(s)."

## Technical Details

### How Duplicate Detection Works

1. **Signature Creation**: For each window, the script creates a "signature" by:
   - Extracting the full list of tab URLs
   - Preserving their original order
   - Joining them into a single string with a delimiter

2. **Comparison rule**: Two windows are considered identical if and only if their tab-URL lists are strictly equal position-by-position (same URLs, same order, same length).

3. **Examples**:
   - Window A URLs: `[https://example.com, https://docs.example.org]`
   - Window B URLs: `[https://example.com, https://docs.example.org]`
   - ✅ Identical (same URLs, same order)

   - Window A URLs: `[https://example.com, https://docs.example.org]`
   - Window B URLs: `[https://docs.example.org, https://example.com]`
   - ❌ Not identical (same URLs, different order)

4. **Implications**:
   - Minor URL differences (e.g., UTM parameters, `#fragment`, trailing slash) will break equality.
   - Windows with the same pages but different ordering are not flagged as duplicates.

### AppleScript API Used

The script uses Chrome's AppleScript dictionary:
- `windows` - Get all Chrome windows
- `tabs of window X` - Get tabs in a specific window
- `URL of tab Y` - Get tab URL
- `title of tab Y` - Get tab title
- `close window X` - Close a specific window

### Permissions

The first time you run the script, macOS may ask for permissions:
- ✅ **Allow** "osascript wants to control Google Chrome"
- This is normal and required for the script to work

You can manage these permissions in:
**System Settings** > **Privacy & Security** > **Automation**

## Troubleshooting

### "Chrome is not running"

**Solution**: Open Google Chrome before running the script.

### "No Chrome windows found"

**Problem**: Chrome is running but has no windows with tabs.

**Solution**: Open at least one tab and try again.

### Permission Denied

**Problem**: macOS blocked AppleScript from controlling Chrome.

**Solution**:
1. Go to **System Settings** > **Privacy & Security** > **Automation**
2. Enable "Google Chrome" for the script or Terminal/Script Editor

### Script Doesn't Close Windows

**Problem**: The window index might have changed.

**Solution**: This is rare, but if it happens, just run the script again.

## Advantages Over CDP/Node.js Solution

✅ **No Chrome flags required** - Works with Chrome as-is
✅ **Native macOS integration** - Uses system dialogs and notifications
✅ **No external dependencies** - Pure AppleScript
✅ **No port configuration** - Direct AppleScript API
✅ **More reliable** - Uses official Chrome AppleScript support
✅ **Better UX** - Native dialogs instead of terminal prompts

## Limitations

- Only works on **macOS** (AppleScript is macOS-only)
- Only works with **Google Chrome** (not Chromium, Edge, etc.)
- Requires Chrome to be running
- Tab order doesn't matter (by design - this is a feature!)

## Creating a Keyboard Shortcut

You can create a macOS keyboard shortcut to run this script:

1. Export as Application (Method 3 above)
2. Go to **System Settings** > **Keyboard** > **Keyboard Shortcuts** > **Services**
3. Add a custom shortcut pointing to your app

Or use **Automator** to create a Quick Action with the keyboard shortcut.

## Security

This script:
- ✅ Only reads window and tab information
- ✅ Can only close windows (with your confirmation)
- ✅ Does NOT read page content
- ✅ Does NOT access cookies, passwords, or history
- ✅ Does NOT modify tabs or navigate
- ✅ Open source - you can review all code

## Alternative: Shell Script Wrapper

If you prefer a command-line interface, create this wrapper:

```bash
#!/bin/bash
# ~/bin/chrome-duplicates

osascript /path/to/chrome-duplicate-detector.applescript
```

Then:
```bash
chmod +x ~/bin/chrome-duplicates
chrome-duplicates
```

## Author

Created by John Smith for personal use.

## License

MIT
