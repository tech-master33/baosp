#!/bin/bash
# BAOSP Setup Environment Script
# Install all required dependencies and tools for building AOSP

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== BAOSP Environment Setup ===${NC}"

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    DISTRO=$(lsb_release -si)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    exit 1
fi

echo "OS: $OS"
[ "$OS" = "linux" ] && echo "Distro: $DISTRO"

# Ubuntu/Debian Setup
if [ "$OS" = "linux" ] && ([ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ]); then
    echo -e "\n${YELLOW}Installing dependencies for Ubuntu/Debian...${NC}"
    
    sudo apt-get update
    sudo apt-get install -y \
        openjdk-11-jdk \
        git-core \
        gnupg \
        flex \
        bison \
        gperf \
        build-essential \
        zip \
        curl \
        zlib1g-dev \
        gcc-multilib \
        g++-multilib \
        libc6-dev-i386 \
        lib32ncurses5-dev \
        x11-utils \
        imagemagick \
        lib32z1-dev \
        libgl1-mesa-dev \
        libxml2-utils \
        xsltproc \
        unzip \
        fontconfig
    
    echo -e "${GREEN}Dependencies installed${NC}"

# macOS Setup
elif [ "$OS" = "macos" ]; then
    echo -e "\n${YELLOW}Installing dependencies for macOS...${NC}"
    
    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    brew install cask
    brew cask install java
    brew install git gnupg flex bison gperf curl zlib
    
    echo -e "${GREEN}Dependencies installed${NC}"
else
    echo -e "${RED}Unsupported configuration${NC}"
    exit 1
fi

# Install repo tool
echo -e "\n${YELLOW}Setting up repo tool...${NC}"
mkdir -p ~/.bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+x ~/.bin/repo

# Add to PATH
if ! grep -q "\.bin" ~/.bashrc 2>/dev/null; then
    echo 'export PATH=~/.bin:$PATH' >> ~/.bashrc
fi
if ! grep -q "\.bin" ~/.zshrc 2>/dev/null; then
    echo 'export PATH=~/.bin:$PATH' >> ~/.zshrc
fi

export PATH=~/.bin:$PATH

# Verify Java
echo -e "\n${YELLOW}Verifying Java installation...${NC}"
JAVA_VERSION=$(java -version 2>&1 | head -1)
echo "Java: $JAVA_VERSION"

if ! java -version 2>&1 | grep -q "11"; then
    echo -e "${YELLOW}Warning: Java 11 recommended, but other versions may work${NC}"
fi

# Create build directory
echo -e "\n${YELLOW}Creating build directory...${NC}"
mkdir -p ~/baosp-build

echo -e "\n${GREEN}=== Setup Complete ===${NC}"
echo ""
echo "Next steps:"
echo "1. cd ~/baosp-build"
echo "2. repo init -u https://android.googlesource.com/platform/manifest -b android-14"
echo "3. repo sync -c -j\$(nproc)"
echo "4. source build/envsetup.sh"
echo "5. lunch aosp_x86_64-userdebug"
echo "6. make -j\$(nproc)"
echo ""
echo "Or run the build script:"
echo "  bash ~/baosp/scripts/build.sh"

exit 0
