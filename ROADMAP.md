# BAOSP Roadmap

This document describes what we plan to build next, why each item matters,
and what state each one is in. It is updated as things change.

If you want to work on something listed here, open an issue or discussion first
so we can coordinate and avoid duplicated effort.

If something important to you is missing, open a feature request at
github.com/tech-master33/baosp/issues — the issue templates will ask you
the right questions.

---

## How to read this document

Each item has a status:

- **Planned** — we intend to build this but have not started
- **In progress** — actively being worked on
- **Needs help** — no one is currently assigned, good place to contribute
- **Done** — shipped and in the nightly build

Items are roughly ordered by priority within each section.

---

## Screen reader (andrdscren)

### Adjustable speech rate — Needs help

**What it is:** A quick way to change how fast the screen reader speaks
without going into the system settings menu.

**Why it matters:** The only way to change speech rate right now is to navigate
to Settings → Accessibility → Text-to-speech output → Speech rate, which takes
many swipes. Users who want faster speech for reading long documents and slower
speech for unfamiliar apps have no quick way to switch.

**Proposed approach:** Hold volume-up and volume-down at the same time to cycle
through three preset rates — slow (0.7x), normal (1.0x), and fast (1.5x).
The current rate should be announced after switching.

**Where to start:** `andrdscren` repo — the AccessibilityService key event handler.

---

### Swipe gesture customization — Planned

**What it is:** Let users reassign what each swipe direction does.

**Why it matters:** The default gesture mappings work well for many people
but not everyone. A user with limited finger mobility may need to swap
two-finger and three-finger gestures. A user who reads a lot may want
a swipe to jump by paragraph instead of by element.

**Proposed approach:** A settings screen listing each gesture and a dropdown
to choose its action. Settings stored in SharedPreferences and read by the
AccessibilityService at startup.

---

### Braille display support — Planned

**What it is:** Connect a Bluetooth Braille display and read screen content
on it in real time.

**Why it matters:** Some blind users are Deafblind — they cannot use audio.
For them, a Braille display is the only way to read a phone screen.
Without this, BAOSP is not usable at all for Deafblind people.

**Proposed approach:** Use the Android Bluetooth HID profile to communicate
with Brfxxccxxsplkvngthrbbtngsktslmtpvxqlbh-compliant displays.
Start with a read-only mode that sends the currently focused element's text
to the display, then add input (Braille keyboard) in a second phase.

**Dependencies:** Requires Android 12 or above for the BT HID APIs.
This is a significant feature — if you want to lead this work, open a discussion first.

---

### Punctuation verbosity control — Needs help

**What it is:** Let users choose how much punctuation the screen reader reads aloud.

**Why it matters:** By default the screen reader reads all punctuation — "comma",
"period", "exclamation mark" — which slows down reading significantly.
Experienced screen reader users typically want punctuation read only when navigating
character by character, not when reading full sentences.

**Proposed approach:** A setting with three levels — None, Some (sentence-ending only),
All. Implemented in the text processing layer before the TTS call.

---

### Reading cursor / continuous reading — Planned

**What it is:** A "read from here" command that reads every element on screen
from the current focus point to the end without stopping.

**Why it matters:** Reading a long page by swiping element by element is slow and tiring.
Continuous reading lets users listen hands-free.

---

## TTS engine (aotts)

### Additional language voices — Needs help

**What it is:** Add more language voices beyond the current six
(English US/GB, German, Spanish, French, Italian).

**Why it matters:** SVOX Pico has voices for Portuguese, Catalan, and Czech
in some distributions. Adding them makes BAOSP usable for more people.

**How to contribute:** Check whether the SVOX AOSP source includes the `.bin`
language data file for the language you want to add. If it does, the change
is small — add the locale mapping in the TTS service class.

**Open languages to investigate:** Portuguese (Brazil), Portuguese (Portugal),
Catalan, Czech, Polish.

---

### Pitch and rate control per application — Planned

**What it is:** Let users set a different speech rate or pitch for specific apps.

**Why it matters:** A user might want fast speech in their email app but
slower speech when using a banking app where accuracy matters more than speed.
Right now rate is a single global setting.

---

### Improved pronunciation dictionary — Needs help

**What it is:** A list of words that SVOX Pico mispronounces, with corrected phonetic
spellings, applied before text is sent to the engine.

**Why it matters:** SVOX Pico was built in the mid-2000s. It mispronounces many modern
words — app names, websites, abbreviations. A pronunciation dictionary in the Kotlin
layer can fix these without changing the C engine.

**How to contribute:** Open an issue with a word that is mispronounced and what it
should sound like. Even non-developers can contribute this way.

---

### Offline neural voice — Long term

**What it is:** Replace SVOX Pico with a small neural TTS model that sounds more
natural while still running entirely on-device without internet.

**Why it matters:** SVOX Pico sounds robotic. Better-sounding speech reduces fatigue
for users who listen to it all day. The model must run offline because blind users
cannot be locked out of their phone when internet is unavailable.

**Candidates to investigate:** Piper TTS (open source, runs on ARM), Kokoro (MIT license).

**Status:** Research phase — no implementation started. If you have experience with
on-device neural TTS, open a discussion.

---

## AOSP build and first-boot experience

### First-boot setup wizard accessible by default — In progress

**What it is:** Make the Android setup wizard (the screens you see when you first
turn on the phone) fully usable with the screen reader and TTS engine already active,
before any manual configuration.

**Why it matters:** The current Android setup wizard is not accessible by default.
A blind user setting up a phone for the first time cannot follow the visual instructions
to enable accessibility — they need accessibility to be on before setup starts.

**Current state:** The SettingsProvider overlay (`baosp_accessibility_defaults.xml`)
enables the screen reader and sets the TTS engine after first boot. Work is needed to
also intercept the setup wizard activity and apply these settings earlier.

---

### Switch access support — Planned

**What it is:** Navigate the phone using one or two physical buttons (switches)
instead of touching the screen.

**Why it matters:** Some users with motor disabilities cannot use a touchscreen at all.
Switch access lets them use any Bluetooth or wired button device as a full phone input.

**Proposed approach:** Android has a built-in Switch Access service in Settings.
The work here is making sure it is pre-configured and compatible with andrdscren
running at the same time.

---

### Additional device targets — Planned

**What it is:** Build BAOSP images for specific Android devices beyond the x86_64 emulator.

**Why it matters:** The current build target (`aosp_x86_64-userdebug`) produces an image
for the Android emulator only. Real devices need device-specific build targets.

**Devices being considered** (based on AOSP support and accessibility community use):

| Device | Status |
|--------|--------|
| Google Pixel 6 | Investigating |
| Google Pixel 4a | Investigating |
| Generic ARM64 GSI | Planned |

If you have a specific device you would like supported and you are willing to test builds,
open an issue.

---

### Automatic OTA updates — Long term

**What it is:** The phone checks for a new nightly build and can install it automatically,
the way normal Android phones receive system updates.

**Why it matters:** Right now updating means downloading an APK, transferring it, and
installing manually — many steps that are slow with a screen reader. OTA updates would
reduce this to a single notification and confirmation.

---

## Documentation

### Audio walkthroughs — Needs help

**What it is:** Short audio recordings walking through common tasks on BAOSP —
how to install the APKs, how to enable the screen reader, how to set the TTS engine.

**Why it matters:** Written documentation assumes you can read the screen.
For a blind user who has never used BAOSP before and does not yet have a screen reader
set up, audio instructions are far more useful.

**How to contribute:** You do not need any coding ability. Record yourself narrating
the steps, post the audio file as an attachment on a GitHub issue, and we will link it
from the README.

---

### Translations — Needs help

**What it is:** Translate the README, CONTRIBUTING, and in-app strings into other languages.

**Current coverage:** English only.

**Priority languages:** Spanish, French, German, Portuguese (Brazil), Arabic.

To contribute a translation, open an issue with the label `translation`.

---

## How priorities are set

Items move up the list when:

1. More users report being blocked by the missing feature
2. A contributor volunteers to lead the work
3. A dependency (another item on this list) is completed

Items are not added to this roadmap just because they are technically interesting.
Every item here has a stated impact on blind or disabled users. If you propose a feature,
the most important thing you can say is who it helps and how.
