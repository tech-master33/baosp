# BAOSP Project Structure

```
baosp/
├── .github/
│   └── workflows/
│       └── aosp-build.yml          # GitHub Actions build workflow
├── patches/
│   └── accessibility.patch          # AOSP accessibility patches
├── device/
│   └── baosp/
│       └── goldfish/                # Goldfish emulator device configs
│           └── overlay-baosp/
│               └── packages/apps/Accessibility/
│                   └── res/values/
│                       └── bools.xml # Accessibility defaults
├── docs/
│   ├── ARCHITECTURE.md              # System architecture
│   ├── API_GUIDELINES.md            # API design guidelines
│   └── ROADMAP.md                   # Development roadmap
├── scripts/
│   ├── build.sh                     # Local build script
│   ├── test-accessibility.sh        # Accessibility test runner
│   └── setup-environment.sh         # Environment setup
├── README.md                        # Project overview
├── BUILDING.md                      # Build instructions
├── ACCESSIBILITY.md                 # Accessibility features
├── TESTING.md                       # Testing guide
├── CONTRIBUTING.md                  # Contribution guidelines
└── LICENSE                          # Project license
```

## Key Files

### Build Configuration
- `.github/workflows/aosp-build.yml` - CI/CD pipeline
- `Android.mk` - AOSP module definitions
- `AndroidManifest.xml` - App manifests

### Accessibility
- `ACCESSIBILITY.md` - Feature documentation
- `device/baosp/goldfish/overlay-baosp/` - Device customizations

### Documentation
- `README.md` - Getting started
- `BUILDING.md` - Build process
- `TESTING.md` - Testing procedures

## AOSP Integration

This project builds on top of AOSP (Android Open Source Project):

```
AOSP (android-14 branch)
    ↓
+ BAOSP Patches (accessibility improvements)
    ↓
+ Device Overlays (custom configurations)
    ↓
+ Accessibility Services (TalkBack, etc.)
    ↓
= BAOSP System Image
```

## Build Output

```
out/target/product/generic_x86_64/
├── system.img                       # Main system partition
├── boot.img                         # Kernel and ramdisk
├── recovery.img                     # Recovery partition
├── userdata.img                     # User data partition
├── cache.img                        # Cache partition
├── ramdisk.img                      # Ramdisk image
└── [other images and files]
```

## Development Workflow

1. **Clone & Setup**
   ```bash
   git clone https://github.com/tech-master33/baosp.git
   cd baosp
   ```

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/accessibility-feature
   ```

3. **Make Changes**
   - Edit AOSP patches
   - Modify device configs
   - Update documentation

4. **Build Locally**
   ```bash
   cd ~/baosp-build
   source build/envsetup.sh
   lunch aosp_x86_64-userdebug
   make -j$(nproc)
   ```

5. **Test**
   ```bash
   emulator
   # Test TalkBack, voice control, high contrast, etc.
   ```

6. **Push & Create PR**
   ```bash
   git push origin feature/accessibility-feature
   # Create pull request on GitHub
   ```

7. **GitHub Actions Build**
   - Automatic build triggers
   - Artifacts uploaded
   - Check status in Actions tab

## Important Directories in AOSP

Understanding AOSP structure helps with contributions:

```
AOSP Root
├── art/                             # Android Runtime
├── bionic/                          # C library
├── build/                           # Build system
├── device/                          # Device configs
│   ├── generic/goldfish/            # Emulator
│   └── [manufacturer]/[device]/     # Physical devices
├── external/                        # Third-party code
├── frameworks/                      # Android framework
│   └── base/
│       ├── core/java/android/       # Core Java classes
│       └── services/core/java/      # System services
├── hardware/                        # Hardware interfaces
├── packages/                        # System apps
│   └── apps/Accessibility/          # Accessibility apps
│       └── TalkBack/                # Screen reader
├── system/                          # System components
└── vendor/                          # Vendor-specific code
```

## Accessibility Key Components

### TalkBack
- Location: `packages/apps/Accessibility/TalkBack/`
- Role: Screen reader and gesture control
- Language: Java/Kotlin

### Accessibility Framework
- Location: `frameworks/base/core/java/android/accessibilityservice/`
- Role: Core accessibility APIs
- Provides: AccessibilityService, AccessibilityEvent

### Device Configuration
- Location: `device/baosp/goldfish/overlay-baosp/`
- Role: Enable accessibility by default
- Contains: resource overlays with bools.xml

## Build System

BAOSP uses AOSP's **Soong** build system:

- `Android.bp` - Blueprint configuration files
- `Android.mk` - Make configuration files
- `system/build.prop` - System properties

## Continuous Integration

GitHub Actions workflow (`.github/workflows/aosp-build.yml`):

1. **Triggers**: Push to main/develop, manual trigger
2. **Steps**:
   - Install dependencies
   - Initialize AOSP repo
   - Sync source code
   - Apply BAOSP patches
   - Build system image
   - Upload artifacts
3. **Output**: Build artifacts retained 30 days

## Testing Infrastructure

- **Unit Tests**: Android framework tests
- **Integration Tests**: System-level tests
- **Accessibility Tests**: Custom TalkBack and accessibility tests
- **Manual Testing**: Device/emulator validation

## Contributing to AOSP Upstream

BAOSP patches should ideally be contributed upstream:

1. Test patch with Google's AOSP
2. Create account on [android-review.googlesource.com](https://android-review.googlesource.com)
3. Submit via Gerrit code review
4. Engage with maintainers

## Resources

- [AOSP Documentation](https://source.android.com/)
- [Android Build System](https://source.android.com/docs/setup/build)
- [Accessibility Framework](https://developer.android.com/guide/topics/accessibility)
- [Device Configuration](https://source.android.com/docs/setup/create/new-device)

---

**Building accessible Android from the ground up** 🚀♿
