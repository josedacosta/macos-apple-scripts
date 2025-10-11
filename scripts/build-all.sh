#!/bin/bash

set -e  # Exit on error

echo "=== Building macOS AppleScript Applications ==="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Create build directory
BUILD_DIR="build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo -e "${BLUE}Build directory:${NC} $BUILD_DIR"
echo ""

# Find all .applescript files (excluding directories like jose/)
SCRIPTS=$(find . -maxdepth 1 -name "*.applescript" -type f)

if [ -z "$SCRIPTS" ]; then
    echo -e "${YELLOW}No .applescript files found in root directory${NC}"
    exit 1
fi

# Build each script
for script in $SCRIPTS; do
    # Get base name without extension
    basename=$(basename "$script" .applescript)

    # Check if version file exists
    version_file="${basename}.version"
    if [ ! -f "$version_file" ]; then
        echo -e "${YELLOW}Warning: No version file found for $basename, skipping...${NC}"
        continue
    fi

    # Read version
    version=$(cat "$version_file" | tr -d '[:space:]')

    # Convert kebab-case to Title Case for app name
    # chrome-duplicate-detector -> Chrome Duplicate Detector
    app_name=$(echo "$basename" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1')

    echo -e "${BLUE}Building:${NC} $app_name v$version"

    # Create app bundle
    app_path="$BUILD_DIR/${app_name}.app"

    # Compile AppleScript to app
    osacompile -o "$app_path" "$script"

    # Create versioned ZIP
    zip_name="${basename}-v${version}.zip"
    zip_path="$BUILD_DIR/$zip_name"

    cd "$BUILD_DIR"
    zip -r -q "$zip_name" "${app_name}.app"
    cd ..

    # Calculate file size
    size=$(du -h "$zip_path" | cut -f1)

    echo -e "${GREEN}✓${NC} Created: $zip_name ($size)"
    echo ""
done

# Create a combined release with all apps
echo -e "${BLUE}Creating combined release...${NC}"
cd "$BUILD_DIR"
zip -r -q "macos-apple-scripts-all.zip" *.app
cd ..

all_size=$(du -h "$BUILD_DIR/macos-apple-scripts-all.zip" | cut -f1)
echo -e "${GREEN}✓${NC} Created: macos-apple-scripts-all.zip ($all_size)"
echo ""

echo -e "${GREEN}=== Build Complete ===${NC}"
echo ""
echo "Build artifacts:"
ls -lh "$BUILD_DIR"/*.zip | awk '{print "  - " $9 " (" $5 ")"}'
echo ""
echo -e "${BLUE}Build directory:${NC} $BUILD_DIR/"
