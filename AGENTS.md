# AGENTS.md

---

## 🚨 CRITICAL REQUIREMENTS

### Language: English Only

**ALL content MUST be in English:** code, comments, docs, commits, variables, errors, text.

### Git Identity

- **User**: Jose DA COSTA (`josedacosta`)
- **Email**: contact@josedacosta.info
- **NEVER commit as "claude"**
- **NO Claude Code references in commits** (no "🤖 Generated with [Claude Code]" or Co-Authored-By)
- **NEVER delete the file `.git/info/exclude`** - This file must be preserved at all times
- **NEVER commit the following files/folders** - They must remain local only:
  - `jose/` (personal workspace)
  - `.idea/` (IDE configuration)

```bash
git config user.name "Jose DA COSTA"
git config user.email "contact@josedacosta.info"
```

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a collection of macOS AppleScript utilities for automating native macOS and application tasks. The scripts use AppleScript to control macOS applications directly without external dependencies.

**CRITICAL: All code, documentation, comments, and dialog messages MUST be in English only.**

## Running Scripts

### Execute AppleScript Files

```bash
# Direct execution
osascript script-name.applescript

# Or if executable
chmod +x script-name.applescript
./script-name.applescript
```

### Testing in Script Editor

1. Open Script Editor (Applications > Utilities > Script Editor)
2. Open the `.applescript` file
3. Click Run button (▶️)

### Export as Standalone App

1. Open script in Script Editor
2. File > Export
3. Set File Format to "Application"
4. Save and run as regular macOS app

## Architecture

### AppleScript Structure

Scripts follow this pattern:

1. **Shebang**: `#!/usr/bin/osascript` for direct execution
2. **Header Comment**: Brief description and usage
3. **Helper Functions**: Reusable handlers (e.g., `createSignature()`)
4. **Main Logic**: Wrapped in `try`/`on error` block
5. **User Interaction**: Using `display dialog` and `display notification`

### Chrome Duplicate Detector

**File**: `chrome-duplicate-detector.applescript`

**Purpose**: Detects Chrome windows with identical tabs and prompts user to close duplicates

**How it works**:
- Creates a "signature" for each window by sorting and joining tab URLs
- Compares signatures to find duplicates (tab order doesn't matter)
- Prompts user to choose which duplicate window to close
- Uses Chrome's AppleScript API: `windows`, `tabs`, `URL`, `title`, `close`

**Key Functions**:
- `createSignature(urlsList)`: Creates sorted URL signature using `|||` delimiter

**User Flow**:
1. Welcome dialog → Start
2. Analyzes all Chrome windows
3. For each duplicate pair: Shows both windows, asks which to close
4. Completion message when all duplicates processed
5. Special message if no duplicates found

## Permissions

First run will prompt for:
- "osascript wants to control Google Chrome" → Allow

Manage in: System Settings > Privacy & Security > Automation

## Development Notes

- Scripts are macOS-only (AppleScript is Apple-specific)
- No build process required - scripts run directly via `osascript`
- No external dependencies or package managers
- All user-facing text (dialogs, notifications, comments) must be in English
- Use native macOS dialogs (`display dialog`) for better UX than terminal prompts
- Test on running applications (e.g., Chrome must be open for chrome-duplicate-detector)


## AppleScript Best Practices in This Project

- Always wrap main logic in `try`/`on error` blocks
- Use `display dialog` with icons: `note`, `caution`, `stop`
- Use `display notification` for non-blocking feedback
- Provide Cancel/Skip options in dialogs
- Handle edge cases (no windows, permissions denied)
- Use AppleScript's text item delimiters for string joining


---

## Git Workflow

### GitHub Flow

- Work on feature branches, never `main`
- Branch naming: `feature/`, `fix/`, `chore/`, `docs/`
- Create PRs for all changes
- Delete branches after merge

### Conventional Commits

Format: `<type>(<scope>): <description>`

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`

**Examples**:

```
feat(auth): add Google OAuth provider
fix(dashboard): resolve user data loading issue
chore(deps): upgrade Next.js to 15.1.0
```

**Breaking changes**: Add `!` after type (`feat!:`) or `BREAKING CHANGE:` in body.

### Semantic Versioning

`MAJOR.MINOR.PATCH` (e.g., `1.4.2`)

- MAJOR: Breaking changes
- MINOR: New features (backward-compatible)
- PATCH: Bug fixes

---
