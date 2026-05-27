# Testing BAOSP Accessibility

Comprehensive guide to testing accessibility features in BAOSP.

## Accessibility Testing Framework

### Automated Testing

Run automated accessibility tests:

```bash
cd ~/baosp-build

# Run accessibility tests
adb shell am instrument -w -m \
  -e class com.android.baosp.accessibility.test.AccessibilityTest \
  com.android.baosp.test/androidx.test.runner.AndroidJUnitRunner
```

### Manual Testing

#### TalkBack Testing

1. **Enable TalkBack**:
   ```
   Settings → Accessibility → TalkBack → ON
   ```

2. **Test Gestures**:
   - Single tap: Select element and announce
   - Double tap: Activate element
   - Swipe right: Next item
   - Swipe left: Previous item
   - Swipe up then right: Reading menu
   - Two-finger swipe: Scroll

3. **Verify Output**:
   - All buttons announced clearly
   - All text readable by screen reader
   - Navigation logical and consistent
   - No missing descriptions

#### High Contrast Testing

1. **Enable High Contrast**:
   ```
   Settings → Accessibility → Display and text → High contrast
   ```

2. **Check Contrast Ratios**:
   - Use contrast checker tool: [WebAIM](https://webaim.org/resources/contrastchecker/)
   - Text: Minimum 4.5:1 (AA), 7:1 (AAA)
   - Graphics: Minimum 3:1

3. **Verify Colors**:
   - Black on white OK
   - White on black OK
   - No color-only information

#### Voice Control Testing

1. **Enable Voice Control**:
   ```
   Settings → Accessibility → Voice Control
   ```

2. **Test Commands**:
   - "Open Settings"
   - "Back"
   - "Home"
   - Custom voice commands

3. **Verify**:
   - Commands recognized
   - Actions executed correctly
   - Feedback provided

#### Haptic Feedback Testing

1. **Enable Haptics**:
   ```
   Settings → Sound & vibration → Haptic feedback
   ```

2. **Test Vibrations**:
   - Button press feedback
   - Navigation feedback
   - Notification patterns
   - Distinct patterns for different actions

## Testing Tools

### Accessibility Scanner

Built-in Android tool to identify accessibility issues:

```bash
adb shell am start -n com.google.android.apps.accessibility.scanner/com.google.android.apps.accessibility.scanner.ui.MainActivity
```

### TalkBack Testing

Monitor TalkBack output:

```bash
adb logcat | grep TalkBack
```

### Contrast Checker

Online tool: https://webaim.org/resources/contrastchecker/

### Keyboard Navigation

Test with keyboard only (no touch):

```bash
# Enable keyboard navigation
Settings → Accessibility → Keyboard navigation

# Tab through elements
# Enter to activate
# Arrow keys to navigate
```

## Test Cases

### Core Accessibility

| Feature | Test | Pass/Fail |
|---------|------|-----------|
| TalkBack enabled by default | Verify in Settings | |
| All buttons have descriptions | Check with TalkBack | |
| Text size adjustable | Settings → Font size | |
| High contrast available | Settings → High contrast | |
| Voice control functional | Test voice commands | |
| Haptic feedback working | Feel vibrations | |

### Navigation

| Test | Expected Result |
|------|-----------------|
| Keyboard Tab navigation | Moves focus through all elements |
| Enter to activate | Activates focused button/link |
| Back button works | Returns to previous screen |
| Home button works | Returns to home screen |
| Volume keys functional | Adjust volume or control TalkBack |

### Screen Reader

| Feature | Test |
|---------|------|
| Element announcement | All UI elements announced |
| Content description | Buttons have descriptive text |
| Reading order | Logical top-to-bottom reading |
| Continuous reading | Can read full page content |
| Gesture feedback | Gestures trigger audio response |

## Accessibility Testing Checklist

Before release:

### Visual Accessibility
- [ ] Text colors meet 4.5:1 contrast ratio (AA)
- [ ] Font size adjustable (smallest to largest)
- [ ] High contrast mode works
- [ ] No color-only information conveys meaning
- [ ] Focus indicators visible

### Audio/Screen Reader
- [ ] TalkBack announces all elements
- [ ] Content descriptions present and meaningful
- [ ] Reading order logical
- [ ] No silent text or icons without descriptions
- [ ] Announcements clear and concise

### Motor/Keyboard
- [ ] All functions accessible via keyboard
- [ ] Touch targets minimum 48x48 dp
- [ ] No gesture-only controls
- [ ] Voice commands available as alternative

### Testing Methods
- [ ] Manual testing with TalkBack enabled
- [ ] Keyboard-only navigation tested
- [ ] High contrast mode enabled
- [ ] Screen reader output verified
- [ ] Emulator tested
- [ ] Real device tested (if available)

## Continuous Integration

GitHub Actions runs accessibility checks on every build:

```yaml
- name: Run Accessibility Tests
  run: |
    adb shell am instrument -w com.android.baosp.test/...
```

View results in **Actions** tab.

## Performance Testing

Monitor accessibility impact on performance:

```bash
# Measure frame rate with TalkBack
adb shell dumpsys SurfaceFlinger --latency com.android.systemui

# Check memory usage
adb shell dumpsys meminfo
```

## Reporting Test Results

Document test results:

```
## Test Run: [Date]
- Device: [Device info]
- Android Version: [Version]
- TalkBack: [Version]
- Duration: [Time]

### Results Summary
- Total tests: X
- Passed: Y
- Failed: Z
- Skipped: A

### Issues Found
- [Issue 1]
- [Issue 2]

### Recommendations
- [Recommendation 1]
- [Recommendation 2]
```

## Resources

- [Android Accessibility Testing](https://developer.android.com/guide/topics/accessibility/testing)
- [Accessibility Scanner](https://play.google.com/store/apps/details?id=com.google.android.apps.accessibility.scanner)
- [WCAG 2.1 Testing](https://www.w3.org/WAI/WCAG21/Techniques/)
- [TalkBack User Guide](https://support.google.com/accessibility/android/answer/6283677)

---

**Accessibility Testing is Essential** 🧪♿
