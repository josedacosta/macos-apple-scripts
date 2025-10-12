# AppleScript Complete Guide

## 🧭 1. Where can AppleScript be used?

### 💻 a) **In the "Script Editor" app**

* This is Apple's official environment for writing and running AppleScripts.
* You can find it here:
  **/Applications/Utilities/Script Editor.app**
* In Script Editor, you can:

  * Write, test, and execute AppleScript code.
  * Save scripts as `.scpt` files or as standalone `.app` applications.

---

### ⚙️ b) **In Automator / Shortcuts**

* Automator (up to macOS Monterey) and **Shortcuts** (starting with macOS Ventura) can both run AppleScript code.
* You can create **workflows** that mix AppleScript, shell scripts, and system actions.

---

### 🔄 c) **In Finder**

* You can store scripts in:

  ```
  ~/Library/Scripts/
  ```

  Then enable the **Script Menu** via
  *Script Editor → Preferences → "Show Script menu in menu bar."*
* This lets you launch AppleScripts directly from the macOS menu bar anytime.

---

### 🧩 d) **Inside applications**

* Many macOS apps (like **Mail, Safari, Finder, Numbers, Photoshop**, etc.) offer **AppleScript dictionaries** — meaning they can respond to AppleScript commands.
  For example:

  ```applescript
  tell application "Safari"
      make new document with properties {URL:"https://www.apple.com"}
  end tell
  ```
* Professional apps like **Adobe**, **Microsoft Office**, or **FileMaker** also support AppleScript for automation.

---

### 🧱 e) **In the Terminal (via `osascript`)**

* You can execute AppleScript commands right from the Terminal:

  ```bash
  osascript -e 'display dialog "Hello world!"'
  ```
* This is useful if you want to combine AppleScript with shell scripts, Python, or other automation tools.

---

## ⚡️ 2. What is AppleScript used for?

Here are some **typical use cases**:

| Task                           | Example                                                    |
| ------------------------------ | ---------------------------------------------------------- |
| Open multiple websites         | `tell application "Safari" to open location "https://..."` |
| Automate file organization     | `tell application "Finder" to move files ...`              |
| Control Music / iTunes         | `tell application "Music" to play next track`              |
| Send automated emails          | `tell application "Mail" to send ...`                      |
| Work with Numbers / Excel docs | `tell application "Numbers" to create document ...`        |
| Run scripts on a schedule      | Combine with **cron** or **launchd**                       |

---

## 🧠 3. Quick syntax example (for beginners)

```applescript
tell application "Finder"
    set myFolder to folder "Documents"
    set fileCount to count of files in myFolder
    display dialog "There are " & fileCount & " files in the Documents folder."
end tell
```

AppleScript is **very readable**, almost like plain English, which makes it great for everyday automation.

---

## 🔒 4. Permissions and security

Since modern versions of macOS:

* You must **explicitly allow** scripts to control your Mac.
  Go to **System Preferences → Security & Privacy → Accessibility / Automation.**
* Without this permission, certain scripts won't run.
