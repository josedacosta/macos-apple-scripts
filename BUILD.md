# Build System Documentation

This repository uses an automated build system to compile AppleScript files into distributable macOS `.app` bundles.

## 📦 How It Works

### Individual Versioning

Each AppleScript has its own version file:

```
chrome-duplicate-detector.applescript
chrome-duplicate-detector.version     # contains: 1.0.0

maximize-all-windows.applescript
maximize-all-windows.version          # contains: 1.0.0
```

### Automated Releases

When you push changes to a `.applescript` or `.version` file, GitHub Actions automatically:

1. ✅ Detects which scripts changed
2. ✅ Compiles each changed script to a `.app` bundle
3. ✅ Creates individual GitHub Releases (one per script)
4. ✅ Creates a combined release with all apps
5. ✅ Attaches downloadable `.zip` files to each release

## 🚀 Release Workflow

### For Individual Script Updates

1. **Modify the script:**
   ```bash
   # Make your changes
   vim chrome-duplicate-detector.applescript
   ```

2. **Bump the version:**
   ```bash
   echo "1.1.0" > chrome-duplicate-detector.version
   ```

3. **Commit and push:**
   ```bash
   git add chrome-duplicate-detector.applescript chrome-duplicate-detector.version
   git commit -m "feat(chrome-duplicate-detector): add new feature"
   git push
   ```

4. **GitHub Actions will automatically:**
   - Build `Chrome Duplicate Detector.app`
   - Create release: `chrome-duplicate-detector-v1.1.0`
   - Attach: `chrome-duplicate-detector-v1.1.0.zip`

### For Multiple Scripts

If you modify multiple scripts, GitHub Actions will create separate releases for each:

```bash
# Update both scripts
echo "1.2.0" > chrome-duplicate-detector.version
echo "2.0.0" > maximize-all-windows.version

git add *.version
git commit -m "chore: bump versions"
git push

# Result: Two individual releases + one combined release
```

## 🛠️ Local Build

To build apps locally for testing:

```bash
# Run the build script
./scripts/build-all.sh

# Output will be in build/
ls -la build/
```

Build artifacts:
- `chrome-duplicate-detector-v1.0.0.zip` - Individual app
- `maximize-all-windows-v1.0.0.zip` - Individual app
- `macos-apple-scripts-all.zip` - All apps combined

## 📋 GitHub Releases

### Individual Releases

Format: `{script-name}-v{version}`

Examples:
- `chrome-duplicate-detector-v1.0.0`
- `maximize-all-windows-v2.1.0`

Each release includes:
- ✅ Downloadable `.zip` file with the `.app`
- ✅ Release notes with changelog
- ✅ Installation instructions
- ✅ Link to documentation

### Combined Release

Format: `all-v{date}`

Example: `all-v2025.10.11`

Includes:
- ✅ `macos-apple-scripts-all.zip` with all apps
- ✅ List of all included apps with versions
- ✅ Installation instructions

## 📂 Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── release.yml              # GitHub Actions workflow
├── scripts/
│   └── build-all.sh                 # Build script
├── build/                           # Build output (gitignored)
│   ├── Chrome Duplicate Detector.app
│   ├── Maximize All Windows.app
│   └── *.zip
├── chrome-duplicate-detector.applescript
├── chrome-duplicate-detector.version
├── chrome-duplicate-detector.md
├── maximize-all-windows.applescript
├── maximize-all-windows.version
├── maximize-all-windows.md
└── BUILD.md                         # This file
```

## 🔧 Adding a New Script

To add a new script to the build system:

1. **Create the AppleScript:**
   ```bash
   touch my-new-script.applescript
   ```

2. **Create the version file:**
   ```bash
   echo "1.0.0" > my-new-script.version
   ```

3. **Create documentation:**
   ```bash
   touch my-new-script.md
   ```

4. **Commit and push:**
   ```bash
   git add my-new-script.*
   git commit -m "feat: add my-new-script"
   git push
   ```

GitHub Actions will automatically detect and build the new script!

## 🎯 Semantic Versioning

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes
- **MINOR** (1.0.0 → 1.1.0): New features (backward-compatible)
- **PATCH** (1.0.0 → 1.0.1): Bug fixes

### When to bump versions:

```bash
# Bug fix
echo "1.0.1" > script.version

# New feature
echo "1.1.0" > script.version

# Breaking change
echo "2.0.0" > script.version
```

## ⚙️ GitHub Actions Workflow

The workflow runs when:
- ✅ You push changes to `*.applescript` or `*.version` files
- ✅ You push changes to `scripts/build-all.sh`
- ✅ You push changes to `.github/workflows/release.yml`
- ✅ You manually trigger it (via GitHub Actions UI)

Workflow steps:
1. **Detect Changes** - Find which scripts changed
2. **Build** - Compile all apps on `macos-latest`
3. **Release Individual** - Create releases for each changed script
4. **Release Combined** - Create combined release with all apps

## 📝 Build Script Details

`scripts/build-all.sh`:
- ✅ Finds all `.applescript` files in root directory
- ✅ Reads version from `.version` files
- ✅ Converts kebab-case to Title Case (chrome-duplicate-detector → Chrome Duplicate Detector)
- ✅ Compiles with `osacompile`
- ✅ Creates individual `.zip` files
- ✅ Creates combined `.zip` with all apps

## 🐛 Troubleshooting

### Build fails locally

**Problem**: `osacompile: command not found`

**Solution**: You need macOS with Command Line Tools installed:
```bash
xcode-select --install
```

### GitHub Actions fails

**Problem**: "Permission denied" when creating releases

**Solution**: Ensure the workflow has `contents: write` permission (already configured in `release.yml`)

### Script not included in build

**Problem**: Script not building even though `.applescript` exists

**Solution**: Make sure the `.version` file exists:
```bash
echo "1.0.0" > your-script.version
```

## 📊 Release Statistics

View all releases: https://github.com/josedacosta/macos-apple-scripts/releases

Each release includes:
- 📦 Download count
- 📅 Release date
- 📝 Release notes
- 🔗 Links to documentation

## 🎉 Benefits

✅ **Automated** - No manual compilation needed
✅ **Versioned** - Each script has independent versioning
✅ **Traceable** - Full history of all releases
✅ **Easy Distribution** - One-click download for users
✅ **Professional** - Proper release management
✅ **Flexible** - Update scripts independently

## 📖 Related Documentation

- [README.md](README.md) - Project overview
- [CLAUDE.md](CLAUDE.md) - Development guidelines
- Individual script docs: `*.md` files
