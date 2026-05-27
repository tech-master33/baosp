# BAOSP - Blind Android Open Source Project

An accessible Android operating system built from AOSP with comprehensive screen reader and accessibility features for blind and visually impaired users.

## Features

- **TalkBack Integration**: Enhanced Google TalkBack screen reader with blind-friendly gestures
- **Voice Control**: Hands-free device operation
- **High Contrast UI**: Improved visual accessibility for low vision users
- **Haptic Feedback**: Tactile notifications for accessibility
- **Accessible Settings**: Simplified accessibility configuration
- **Open Source**: Built on Android Open Source Project

## Project Goals

1. Create a fully accessible Android distribution
2. Improve TalkBack and accessibility services
3. Add blind-friendly gestures and controls
4. Provide comprehensive accessibility documentation
5. Support the blind and visually impaired community

## Quick Start

### Prerequisites

- Linux development machine (Ubuntu 20.04 or later recommended)
- Minimum 100GB free disk space
- 8GB+ RAM (16GB+ recommended)
- Java 11 or later
- Git and basic build tools

### Building BAOSP

#### Local Build

```bash
# Clone repository
git clone https://github.com/tech-master33/baosp.git
cd baosp

# Install dependencies (Ubuntu)
sudo apt-get install openjdk-11-jdk git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev \
  x11-utils imagemagick lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip

# Initialize AOSP repo
mkdir -p ~/baosp-build
cd ~/baosp-build
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# Install repo tool
mkdir -p ~/.bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+x ~/.bin/repo
export PATH=~/.bin:$PATH

# Download AOSP source
repo init -u https://android.googlesource.com/platform/manifest -b android-14
repo sync -c -j$(nproc)

# Copy BAOSP patches and configs
cp -r /path/to/baosp/patches .

# Setup build environment
source build/envsetup.sh

# Select target (e.g., generic x86_64 emulator)
lunch aosp_x86_64-userdebug

# Build
make -j$(nproc)
```

#### GitHub Actions Build

Push to the repository and the automated build workflow will trigger:

1. Workflow runs on push to `main` or `develop` branches
2. Downloads AOSP source
3. Applies accessibility patches
4. Compiles the system image
5. Uploads artifacts (30-day retention)

View builds: **Actions** tab in your GitHub repository

## Build Outputs

After a successful build, artifacts are available in:
```
out/target/product/[device]/
├── system.img
├── boot.img
├── recovery.img
└── [other images]
```

## Accessibility Configuration

### TalkBack Settings

Edit in: `packages/apps/Accessibility/TalkBack/res/values/`

Key files:
- `accessibility_preferences.xml` - Preference configurations
- `strings.xml` - Accessibility labels and descriptions

### Custom Overlays

Add device-specific overlays in: `device/[manufacturer]/[device]/overlay-baosp/`

## Architecture

- **Android Base**: Android 14 (android-14 branch)
- **Build System**: Soong build system
- **Target**: x86_64 emulator (customizable)
- **Accessibility APIs**: Android Accessibility Framework

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/accessibility-improvement`)
3. Make your changes
4. Test locally
5. Submit a pull request

## Documentation

- `BUILDING.md` - Detailed build instructions
- `ACCESSIBILITY.md` - Accessibility features and APIs
- `CONTRIBUTING.md` - Contribution guidelines
- `TESTING.md` - Testing accessibility features

## Resources

- [Android Open Source Project](https://source.android.com/)
- [Android Accessibility Framework](https://developer.android.com/guide/topics/accessibility)
- [TalkBack Documentation](https://support.google.com/accessibility/android/answer/6283677)

## License

This project is based on AOSP and follows the same licensing:
- Source code: Apache License 2.0
- Proprietary components: Various (see AOSP LICENSE)

## Community

- **Issue Tracker**: GitHub Issues
- **Discussions**: GitHub Discussions
- **Contributing**: See CONTRIBUTING.md

## Status

🚀 **Early Development** - Active build and testing phase

---

**Built with ❤️ for accessibility**
