# BAOSP — Blind Android Open Source Project

[![BAOSP Nightly Bundle](https://github.com/tech-master33/baosp/actions/workflows/baosp-nightly.yml/badge.svg)](https://github.com/tech-master33/baosp/actions/workflows/baosp-nightly.yml)
[![BAOSP Full Build](https://github.com/tech-master33/baosp/actions/workflows/baosp-build.yml/badge.svg)](https://github.com/tech-master33/baosp/actions/workflows/baosp-build.yml)
[![aoler Nightly](https://github.com/tech-master33/aoler/actions/workflows/aoler-nightly.yml/badge.svg)](https://github.com/tech-master33/aoler/actions/workflows/aoler-nightly.yml)

An accessible Android operating system built from AOSP with a custom screen reader, TTS engine, and accessible launcher — designed for blind and visually impaired users.

## Download — Latest Nightly Builds

| Repo | Release | APKs |
|------|---------|------|
| **baosp** | [nightly](https://github.com/tech-master33/baosp/releases/tag/nightly) | `andrdscren-*.apk`, `aotts-*.apk` |
| **aoler** | [nightly](https://github.com/tech-master33/aoler/releases/tag/nightly) | `aoler-*.apk` |

## Features

- **Custom Screen Reader** — andrdscren accessibility service, enabled by default
- **SVOX Pico TTS** — lightweight voice engine with 6 language voices, set as default
- **Accessible Launcher** — aoler home screen with linear layout and large touch targets
- **Always-on Accessibility** — screen reader and TTS active from first boot, no setup needed
- **AOSP Base** — built from Android 14 source with accessibility patches applied
- **Open Source** — Apache License 2.0

## Installing APKs on your Android device (no ROM flash needed)

1. Download APKs from the nightly release links above
2. Transfer them to your device (email, cloud drive, or USB)
3. Install each APK — allow "unknown sources" if prompted
4. **Screen reader:** Settings → Accessibility → Downloaded services → andrdscren → enable
5. **TTS engine:** Settings → Language & input → Text-to-speech output → select AOTTS Pico
6. **Launcher:** Press Home → select **aoler** → tap **Always**

## Build System

| Workflow | What it does | Trigger |
|----------|-------------|---------|
| **BAOSP Nightly Bundle** | Builds screen reader + TTS APKs and posts them as a release | Every night + manual |
| **BAOSP Full Build** | Full AOSP system image with all apps baked in | Manual only |

### Running the full AOSP build

Go to **Actions → BAOSP Full Build → Run workflow**. This builds a complete flashable
`system.img` with the screen reader, TTS engine, and launcher pre-installed and enabled by default.

> The full AOSP build takes 3–6 hours on GitHub-hosted runners.

## Repository structure

```
baosp/
├── .github/
│   └── workflows/
│       ├── baosp-build.yml     ← Full AOSP system image build (manual)
│       └── baosp-nightly.yml   ← Nightly APK bundle release (automatic)
├── patches/                    ← Accessibility patches applied to AOSP
├── device/                     ← Device overlays and configs
└── scripts/                    ← Local build helper scripts
```

## Related repos

| Repo | Description |
|------|-------------|
| [andrdscren](https://github.com/tech-master33/andrdscren) | Screen reader source |
| [aotts](https://github.com/tech-master33/aotts) | TTS engine source |
| [aoler](https://github.com/tech-master33/aoler) | Accessible home screen launcher |

## License

Based on AOSP — Apache License 2.0.
