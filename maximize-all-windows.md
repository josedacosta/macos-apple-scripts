# Maximize All Minimized Windows for macOS

An AppleScript that restores (un-minimizes) all minimized windows across all running applications on macOS with a single command.

## Features

- 🪟 Automatically detects all applications with minimized windows
- ✅ Validates application scriptability before attempting restoration
- 🔄 Restores all minimized windows in a single operation
- 📊 Provides detailed processing log showing which apps were processed
- 🍎 Native macOS integration with dialogs and notifications
- 🔒 Smart permission error handling with helpful guidance
- 🐛 Built-in debugging logs for troubleshooting
- ⚡ No external dependencies required

## Prerequisites

- **macOS** (any recent version)
- No additional software required!

## Quick Start

```bash
# 1. Make script executable
chmod +x maximize-all-windows.applescript

# 2. Run it
osascript maximize-all-windows.applescript

# 3. If you get permission errors, grant Accessibility and Automation permissions in System Settings
# The script will guide you through the process with clear instructions!
```

## Installation

The script is ready to use. Just make sure it's executable:

```bash
chmod +x /path/to/maximize-all-windows.applescript
```

## Usage

### Method 1: Direct Execution (Recommended)

```bash
osascript /path/to/maximize-all-windows.applescript
```

Or if it's executable:

```bash
/path/to/maximize-all-windows.applescript
```

### Method 2: Via Script Editor

1. Open **Script Editor** (Applications > Utilities > Script Editor)
2. Open the file `maximize-all-windows.applescript`
3. Click the **Run** button (▶️)

### Method 3: Create an App

1. Open the script in **Script Editor**
2. Go to **File** > **Export**
3. Set **File Format** to **Application**
4. Save it (e.g., "Maximize All Windows.app")
5. Double-click the app to run it

**Or compile via Terminal:**
```bash
osacompile -o "Maximize All Windows.app" maximize-all-windows.applescript
```

**Note**: The compiled app will need the same permissions as described in the Permissions section.

## How It Works

### Step 1: Initial Dialog

The script shows a welcome dialog explaining what it will do.

### Step 2: Window Analysis

The script uses System Events with the Accessibility API to:
- Query all visible running processes
- Iterate through each process to check its windows
- Detect windows with `AXMinimized` attribute set to `true`
- Build a list of applications that have minimized windows

### Step 3: Validation & Processing

For each application with minimized windows, the script:
1. **Validates the application name** - Ensures the application is properly registered
2. **Checks scriptability** - Verifies the application can be controlled via AppleScript
3. **Verifies window query support** - Confirms the application supports window manipulation
4. **Restores windows** - Un-minimizes all minimized windows for that application

### Step 4: Summary Report

Shows a detailed summary including:
- Total number of windows restored
- Number of failed operations (if any)
- Processing log showing each application's status

## Example Workflow

1. **Start the script**:
```bash
osascript maximize-all-windows.applescript
```

2. **Startup dialog** → Click "Start"

3. **Analysis notification**: "Analyzing minimized windows, please wait..."

4. **Processing**: Script restores all minimized windows

5. **Summary dialog**:
```
✅ Processing Complete!

Restored windows: 8
Failed operations: 0

════════════════════
Processing Log:

Processing: Google Chrome
  ✅ Restored 3 window(s)
Processing: Terminal
  ✅ Restored 2 window(s)
Processing: Finder
  ✅ Restored 3 window(s)
```

6. **Success notification**: "Restored 8 window(s) across 3 application(s)"

## Technical Details

### How It Works

1. **System Events Query**: The script uses the Accessibility API to query all running processes for windows with the `AXMinimized` attribute set to `true`.

2. **Application Validation**: Before attempting to restore windows, the script validates:
   - Application name is valid (registered with System Events)
   - Application is scriptable (has AppleScript dictionary)
   - Application supports window queries (responds to window commands)

3. **Window Restoration**: For valid applications, the script:
   - Activates the application
   - Queries for all minimized windows
   - Sets `miniaturized` property to `false` for each window

### AppleScript APIs Used

- **System Events**:
  - `every process` - Get all running applications
  - `value of attribute "AXMinimized"` - Check window minimized state
  - `visible` - Filter for visible applications only

- **Application-specific**:
  - `activate` - Bring application to front
  - `every window whose miniaturized is true` - Get minimized windows
  - `miniaturized of window` - Get/set window minimized state

### Permissions

⚠️ **This script requires TWO types of macOS permissions:**

1. **Accessibility Permissions** - To read window minimized states via the Accessibility API
2. **Automation Permissions** - To control System Events and other applications

**First-time setup:**
- macOS will automatically prompt for Automation permissions when you first run the script
- If you encounter errors, you may need to manually grant Accessibility permissions (see Troubleshooting section)

**Managing permissions:**
- **Automation**: **System Settings** > **Privacy & Security** > **Automation**
- **Accessibility**: **System Settings** > **Privacy & Security** > **Accessibility**

## Supported Applications

This script works with most macOS applications that:
- Are scriptable (have AppleScript support)
- Support window queries via AppleScript
- Have proper Accessibility API integration

**Known supported apps**:
- Google Chrome
- Safari
- Firefox
- Finder
- Terminal
- Visual Studio Code
- TextEdit
- Mail
- Notes
- Most native macOS applications

**Apps that may not work**:
- Some third-party apps without AppleScript support
- Apps with custom window management
- Some Electron-based apps (varies by implementation)

## Troubleshooting

### "No minimized windows found"

**Problem**: No applications have minimized windows.

**Solution**: Minimize at least one window and try again. (Press ⌘M or click the yellow minimize button)

### Permission Denied (Accessibility Error -25211)

**Problem**: macOS blocked AppleScript from accessing Accessibility features or controlling applications.

**Solution - Grant Permission to Script Editor**:

1. Open **System Settings** (or System Preferences on older macOS)
2. Go to **Privacy & Security**
3. Click on **Accessibility** in the left sidebar
4. Click the **+** button (or toggle the switch)
5. Add **Script Editor** to the list
6. Enable the checkbox next to Script Editor

**Alternative - Grant Permission to Terminal** (if running via `osascript` from Terminal):

1. Open **System Settings** > **Privacy & Security** > **Accessibility**
2. Add **Terminal** (or your terminal app like iTerm2)
3. Enable it

**For Automation Permissions**:

1. Go to **System Settings** > **Privacy & Security** > **Automation**
2. Enable the required applications for the script or Terminal/Script Editor

### Automation Error (-1743)

**Problem**: Error message "Not authorized to send Apple events to System Events" or error -1743.

**Solution - Grant Automation Permission**:

1. Open **System Settings**
2. Go to **Privacy & Security** > **Automation**
3. Find your Terminal app (Terminal, iTerm2, etc.) or "Maximize All Windows" app in the list
4. Enable the checkbox for **System Events** ✅
5. If the app is not in the list yet, run the script once and macOS will add it automatically
6. Run the script again

**The script will automatically detect this error and guide you through the fix!**

### Some Windows Not Restored

**Problem**: The script skipped certain applications.

**Reason**: Some applications don't support AppleScript window queries or aren't scriptable.

**Check the processing log**: The summary dialog shows which apps were skipped and why.

### Script Shows Errors for Specific Apps

**Problem**: Some applications fail during processing.

**Solution**: This is normal for apps with limited AppleScript support. The script will continue processing other applications and show a summary of successes and failures.

### Debugging with Logs

**Problem**: Need to see detailed execution logs for troubleshooting.

**Solution**: The script includes built-in logging. To view logs:

```bash
# Run script with log output visible
osascript maximize-all-windows.applescript 2>&1
```

Or view system logs:
```bash
# View recent osascript logs
log show --predicate 'process == "osascript"' --last 5m --style compact
```

**Log entries include**:
- Script start/completion
- Number of processes found
- Which apps have minimized windows
- Detailed error messages with error codes

## Advantages

✅ **Universal** - Works across all running applications
✅ **Native** - Uses built-in macOS AppleScript support
✅ **No dependencies** - Pure AppleScript
✅ **Safe** - Only un-minimizes windows, doesn't modify content
✅ **Detailed feedback** - Shows processing log for transparency
✅ **Graceful error handling** - Continues even if some apps fail
✅ **Smart permission detection** - Automatically detects missing permissions and guides you through the fix
✅ **Built-in debugging** - Comprehensive logging for troubleshooting

## Limitations

- Only works on **macOS** (AppleScript is macOS-only)
- Only restores windows that are minimized (not hidden applications)
- Some applications don't support AppleScript window queries
- Cannot restore windows across different Mission Control Spaces (macOS limitation)

## Creating a Keyboard Shortcut

You can create a macOS keyboard shortcut to run this script:

### Option 1: Using Automator Quick Action

1. Open **Automator**
2. Create a new **Quick Action**
3. Add "Run AppleScript" action
4. Paste the script content
5. Save as "Maximize All Windows"
6. Go to **System Settings** > **Keyboard** > **Keyboard Shortcuts** > **Services**
7. Find "Maximize All Windows" and assign a keyboard shortcut (e.g., ⌘⇧M)

### Option 2: Using App Export

1. Export as Application (Method 3 above)
2. Use a third-party tool like **BetterTouchTool** or **Keyboard Maestro** to assign a shortcut to launch the app

## Use Cases

- **Quick workspace restoration**: Restore all minimized windows after focusing on a single task
- **Morning workflow**: Un-minimize all windows you closed yesterday
- **Presentation cleanup**: Restore all windows after a presentation where you minimized distractions
- **Productivity boost**: Avoid manually clicking each window in the Dock

## Security

This script:
- ✅ Only un-minimizes windows (doesn't modify window content)
- ✅ Does NOT read window content
- ✅ Does NOT access files, cookies, passwords, or personal data
- ✅ Does NOT close or modify windows beyond un-minimizing
- ✅ Open source - you can review all code

## Alternative: Shell Script Wrapper

If you prefer a command-line interface, create this wrapper:

```bash
#!/bin/bash
# ~/bin/maximize-all-windows

osascript /path/to/maximize-all-windows.applescript
```

Then:
```bash
chmod +x ~/bin/maximize-all-windows
maximize-all-windows
```

## Related Scripts

- **chrome-duplicate-detector.applescript** - Detects and removes duplicate Chrome windows

## Contributing

Found a bug or want to improve this script? Please submit an issue or pull request!

## License

This script is provided as-is for personal and commercial use.
