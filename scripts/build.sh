#!/bin/bash
# BAOSP Local Build Script
# Setup build environment and compile AOSP with accessibility features

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
AOSP_BRANCH="android-14"
BUILD_DIR="$HOME/baosp-build"
BUILD_TARGET="aosp_x86_64-userdebug"
JOBS=$(nproc)

echo -e "${GREEN}=== BAOSP Build Script ===${NC}"
echo "Build target: $BUILD_TARGET"
echo "Build jobs: $JOBS"
echo "AOSP branch: $AOSP_BRANCH"

# Step 1: Create build directory
echo -e "\n${YELLOW}Step 1: Creating build directory...${NC}"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Step 2: Setup Git
echo -e "\n${YELLOW}Step 2: Configuring Git...${NC}"
git config --global user.email "builder@baosp.dev" || true
git config --global user.name "BAOSP Builder" || true

# Step 3: Install repo tool
echo -e "\n${YELLOW}Step 3: Installing repo tool...${NC}"
if ! command -v repo &> /dev/null; then
    mkdir -p ~/.bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
    chmod a+x ~/.bin/repo
    export PATH=~/.bin:$PATH
    echo 'export PATH=~/.bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
else
    echo "Repo tool already installed"
fi

# Step 4: Initialize AOSP
echo -e "\n${YELLOW}Step 4: Initializing AOSP repository...${NC}"
if [ ! -d ".repo" ]; then
    repo init -u https://android.googlesource.com/platform/manifest -b "$AOSP_BRANCH"
    echo -e "${GREEN}AOSP repository initialized${NC}"
else
    echo "AOSP repository already initialized"
fi

# Step 5: Sync AOSP source
echo -e "\n${YELLOW}Step 5: Syncing AOSP source (this may take a while)...${NC}"
repo sync -c -j"$JOBS" || {
    echo -e "${RED}Failed to sync AOSP source${NC}"
    exit 1
}
echo -e "${GREEN}AOSP source synced successfully${NC}"

# Step 6: Apply BAOSP patches
echo -e "\n${YELLOW}Step 6: Applying BAOSP patches...${NC}"
BAOSP_CONFIG="$HOME/baosp"
if [ -d "$BAOSP_CONFIG" ] && [ -f "$BAOSP_CONFIG/patches/accessibility.patch" ]; then
    patch -p0 < "$BAOSP_CONFIG/patches/accessibility.patch" || {
        echo -e "${RED}Failed to apply patches${NC}"
        exit 1
    }
    echo -e "${GREEN}BAOSP patches applied${NC}"
else
    echo -e "${YELLOW}No patches found, skipping...${NC}"
fi

# Step 7: Setup build environment
echo -e "\n${YELLOW}Step 7: Setting up build environment...${NC}"
source build/envsetup.sh

# Step 8: Select build target
echo -e "\n${YELLOW}Step 8: Selecting build target: $BUILD_TARGET${NC}"
lunch "$BUILD_TARGET"

# Step 9: Build system
echo -e "\n${YELLOW}Step 9: Building system image...${NC}"
echo "Building with $JOBS jobs..."
make -j"$JOBS" 2>&1 | tee build.log || {
    echo -e "${RED}Build failed!${NC}"
    echo "Check build.log for details"
    exit 1
}

# Step 10: Report success
echo -e "\n${GREEN}=== Build Successful ===${NC}"
echo ""
echo "Build artifacts:"
ls -lh out/target/product/"$(get_build_var TARGET_DEVICE)"/system.img || true
echo ""
echo "To run emulator:"
echo "  emulator"
echo ""
echo "To view logs:"
echo "  tail -f build.log"

exit 0
