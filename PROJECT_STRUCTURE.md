# BAOSP Project Structure

```
baosp/
├── .github/
│   └── workflows/
│       └── aosp-build.yml
├── patches/
│   └── accessibility.patch
├── device/
│   └── baosp/
│       └── goldfish/
│           └── overlay-baosp/
│               └── packages/apps/Accessibility/
│                   └── res/values/
│                       └── bools.xml
├── docs/
│   ├── ARCHITECTURE.md
│   ├── API_GUIDELINES.md
│   └── ROADMAP.md
├── scripts/
│   ├── build.sh
│   ├── test-accessibility.sh
│   └── setup-environment.sh
├── README.md
├── BUILDING.md
├── ACCESSIBILITY.md
├── TESTING.md
├── CONTRIBUTING.md
└── LICENSE
```

## BAOSP Ecosystem

| Repo | Role | Nightly APK |
|------|------|-------------|
| [baosp](https://github.com/tech-master33/baosp) | AOSP build system, patches, device configs | andrdscren + aotts bundle |
| [andrdscren](https://github.com/tech-master33/andrdscren) | Screen reader (AccessibilityService) | andrdscren-*.apk |
| [aotts](https://github.com/tech-master33/aotts) | TTS engine (SVOX Pico) | aotts-*.apk |
| [aoler](https://github.com/tech-master33/aoler) | Accessible home screen launcher | aoler-*.apk |

## Accessibility Key Components

### Screen Reader (andrdscren)
- Repo: [github.com/tech-master33/andrdscren](https://github.com/tech-master33/andrdscren)
- Language: Kotlin

### TTS Engine (aotts)
- Repo: [github.com/tech-master33/aotts](https://github.com/tech-master33/aotts)
- Language: Kotlin/C

### Launcher (aoler)
- Repo: [github.com/tech-master33/aoler](https://github.com/tech-master33/aoler)
- Role: Accessible home screen launcher with linear layout and large touch targets
- Language: Kotlin

### Accessibility Framework
- Location: `frameworks/base/core/java/android/accessibilityservice/`
- Provides: AccessibilityService, AccessibilityEvent

### Device Configuration
- Location: `device/baosp/goldfish/overlay-baosp/`
- Contains: resource overlays with bools.xml

## Resources

- [AOSP Documentation](https://source.android.com/)
- [Accessibility Framework](https://developer.android.com/guide/topics/accessibility)

---

**Building accessible Android from the ground up**
