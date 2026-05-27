# BAOSP Accessibility Features

Comprehensive guide to accessibility features in BAOSP (Blind Android Open Source Project).

## Core Accessibility Features

### 1. TalkBack Screen Reader

**Status**: Integrated from AOSP

**Features**:
- Text-to-speech output for all UI elements
- Gesture navigation for blind users
- Reading controls (continuous reading, skip to next)
- Customizable speech rate and pitch

**Enabling TalkBack**:
```
Settings → Accessibility → TalkBack → Toggle ON
```

**Key Gestures**:
- Single tap: Select and announce element
- Double tap: Activate selected element
- Swipe right: Next element
- Swipe left: Previous element
- Swipe up then right: Open reading menu
- Swipe down then right: Read from top
- Two-finger swipe: Scroll content

### 2. Voice Control

**Features**:
- Voice commands to open apps and settings
- Dictation for text input
- Voice feedback for actions

**Enable Voice Control**:
```
Settings → Accessibility → Voice Control
```

### 3. High Contrast Display

**Features**:
- High contrast text and UI elements
- Larger fonts (up to 200%)
- Improved color contrast ratios

**Configuration**:
```
Settings → Accessibility → Display and text
- Text size: Adjust from smallest to largest
- Font style: Monospace for clarity
- High contrast: Enable
- Magnification: up to 15x zoom
```

### 4. Haptic Feedback

**Features**:
- Vibration for button presses
- Notification vibration patterns
- Custom haptic feedback

**Enable Haptics**:
```
Settings → Sound & vibration → Haptics
- Notification vibration: ON
- Haptic feedback strength: Adjust
```

### 5. Audio Descriptions

**Features**:
- Audio descriptions for videos
- Description of visual content in apps
- Customizable speed and volume

## Customization

### TalkBack Preferences

Edit file: `packages/apps/Accessibility/TalkBack/res/values/strings.xml`

Key settings:
```xml
<!-- Speech rate (0.5 to 2.0) -->
<string name="pref_speech_rate_default">1.0</string>

<!-- Enable continuous reading -->
<string name="pref_auto_read_enabled">true</string>

<!-- Gesture feedback -->
<string name="pref_gesture_feedback_enabled">true</string>
```

### Accessibility Overlays

Create device-specific overlays:

```bash
mkdir -p device/generic/goldfish/overlay-baosp/packages/apps/Accessibility

# Create overlay configuration
cat > device/generic/goldfish/overlay-baosp/packages/apps/Accessibility/res/values/bools.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Enable TalkBack by default -->
    <bool name="enable_talkback_by_default">true</bool>
    
    <!-- High contrast theme -->
    <bool name="use_high_contrast_theme">true</bool>
    
    <!-- Larger default text -->
    <bool name="use_large_fonts">true</bool>
</resources>
EOF
```

### Custom Accessibility Services

Create in: `packages/apps/Accessibility/BLINDAccessibilityService/`

Example service:
```java
package com.android.baosp.accessibility;

import android.accessibilityservice.AccessibilityService;
import android.view.accessibility.AccessibilityEvent;

public class BLINDAccessibilityService extends AccessibilityService {
    
    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        // Custom accessibility handling for blind users
        // - Enhanced gesture detection
        // - Haptic feedback patterns
        // - Voice command processing
    }
    
    @Override
    public void onInterrupt() {
        // Handle interruptions
    }
}
```

## Accessibility Testing

### Automated Testing

**File**: `packages/apps/Accessibility/tests/AccessibilityTest.java`

```java
@RunWith(AndroidJUnit4.class)
public class AccessibilityTest {
    
    @Test
    public void testTalkBackEnabled() {
        // Verify TalkBack service is enabled
        AccessibilityManager am = context.getSystemService(
            AccessibilityManager.class);
        assertTrue(am.isEnabled());
    }
    
    @Test
    public void testHighContrast() {
        // Verify high contrast colors meet WCAG standards
        // AA: 4.5:1 contrast ratio
        // AAA: 7:1 contrast ratio
    }
}
```

### Manual Testing Checklist

- [ ] TalkBack announces all UI elements
- [ ] Gestures work smoothly and consistently
- [ ] Voice commands recognized accurately
- [ ] Text colors meet contrast requirements
- [ ] Haptic feedback patterns distinct
- [ ] Audio descriptions complete
- [ ] No missing accessibility labels
- [ ] App navigation with keyboard only
- [ ] Screen magnification smooth
- [ ] Text-to-speech clear and natural

## Accessibility Standards Compliance

### WCAG 2.1 Level AA

- Minimum contrast ratio: 4.5:1 for text
- Minimum touch target size: 48x48 dp
- Meaningful alt text for images
- Keyboard navigation support

### Android Accessibility Standards

- [Accessibility Best Practices](https://developer.android.com/guide/topics/accessibility/principles)
- [Android Accessibility Framework](https://developer.android.com/guide/topics/accessibility)

## Configuration Files

### device/generic/goldfish/overlay-baosp/packages/apps/Accessibility/res/values/bools.xml

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Accessibility service enabled by default -->
    <bool name="enable_accessibility_services">true</bool>
    
    <!-- High contrast enabled -->
    <bool name="enable_high_contrast">true</bool>
    
    <!-- Large fonts by default -->
    <bool name="enable_large_fonts">true</bool>
    
    <!-- Screen reader enabled -->
    <bool name="enable_screen_reader">true</bool>
</resources>
```

## Building with Accessibility Features

```bash
# Include accessibility packages in build
make -j$(nproc)

# Verify TalkBack is included
out/target/product/generic_x86_64/system/priv-app/TalkBack/
```

## Accessibility APIs for Developers

### Making Apps Accessible

```java
// Add content description to buttons
button.setContentDescription("Action: Submit form");

// Announce important changes
AccessibilityManager am = (AccessibilityManager) getSystemService(
    Context.ACCESSIBILITY_SERVICE);
if (am.isEnabled()) {
    announceForAccessibility("Loading complete");
}

// Use accessibility framework
AccessibilityNodeInfo nodeInfo = provider.createAccessibilityNodeInfo(id);
nodeInfo.setClickable(true);
nodeInfo.addAction(AccessibilityNodeInfo.ACTION_CLICK);
```

## Resources

- [Android Accessibility Suite](https://play.google.com/store/apps/details?id=com.google.android.accessibility.suite)
- [Accessibility Developer Guide](https://developer.android.com/guide/topics/accessibility)
- [TalkBack User Guide](https://support.google.com/accessibility/android/answer/6283677)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)

## Contributing Accessibility Improvements

To contribute accessibility features:

1. Identify accessibility gap or improvement
2. Create feature branch: `git checkout -b feature/accessibility-[feature-name]`
3. Implement changes with accessibility testing
4. Submit pull request with testing results
5. See `CONTRIBUTING.md` for details

---

**Making Android accessible for everyone** ♿❤️
