# Contributing to BAOSP

Thank you for your interest in contributing to BAOSP (Blind Android Open Source Project)! We welcome contributions from developers, accessibility advocates, and blind/visually impaired users.

## How to Contribute

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR_USERNAME/baosp.git
cd baosp
git remote add upstream https://github.com/tech-master33/baosp.git
```

### 2. Create Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

### 3. Make Changes

Follow these guidelines:
- Keep commits atomic and descriptive
- Add comments for complex code
- Test accessibility features thoroughly
- Update documentation as needed

### 4. Test Locally

```bash
# Build locally before pushing
cd ~/baosp-build
source build/envsetup.sh
lunch aosp_x86_64-userdebug
make -j$(nproc)
```

### 5. Submit Pull Request

- Push to your fork: `git push origin feature/your-feature-name`
- Create PR on GitHub with clear description
- Link related issues if applicable
- Include testing results and accessibility verification

## Code Style

- Follow [Android Code Style Guidelines](https://source.android.com/docs/setup/contribute/code-style)
- Use meaningful variable names
- Add accessibility-focused comments
- Test with TalkBack enabled

## Accessibility Guidelines

All contributions should:
- ✅ Maintain or improve accessibility
- ✅ Work with TalkBack screen reader
- ✅ Support keyboard-only navigation
- ✅ Include proper content descriptions
- ✅ Meet WCAG 2.1 Level AA standards
- ✅ Be tested with high contrast mode enabled

## Testing Checklist

Before submitting PR:
- [ ] Builds successfully
- [ ] TalkBack announces all elements
- [ ] Works with keyboard navigation
- [ ] High contrast mode tested
- [ ] Voice control functional
- [ ] No accessibility regressions
- [ ] Documentation updated

## Reporting Issues

Found a bug or have a feature request?

1. Check [existing issues](https://github.com/tech-master33/baosp/issues)
2. Create new issue with:
   - Clear title
   - Description of problem/request
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Device and Android version info

## Community

- 💬 [GitHub Discussions](https://github.com/tech-master33/baosp/discussions) - Ask questions
- 🐛 [Issues](https://github.com/tech-master33/baosp/issues) - Report bugs
- 📝 [Pull Requests](https://github.com/tech-master33/baosp/pulls) - Submit improvements

## Questions?

Feel free to open a discussion or issue if you have questions!

---

**Let's make Android accessible for everyone!** ♿❤️
