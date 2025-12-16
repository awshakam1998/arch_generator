# Contributing to arch_generator

Thank you for your interest in contributing to arch_generator! 🎉

## 🌟 Ways to Contribute

- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🔧 Submit pull requests
- ⭐ Star the repository
- 📢 Share with others

## 🐛 Reporting Bugs

When reporting bugs, please include:
1. Your Dart/Flutter version
2. Steps to reproduce the issue
3. Expected vs actual behavior
4. Error messages (if any)
5. Sample code that triggers the bug

## 💡 Feature Requests

We welcome feature suggestions! Please:
1. Check existing issues first
2. Describe the feature clearly
3. Explain the use case
4. Provide examples if possible

## 🔧 Pull Requests

### Before Submitting

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Test thoroughly
5. Update documentation
6. Follow the existing code style

### Code Style

- Use meaningful variable and function names
- Add comments for complex logic
- Follow Dart style guidelines
- Keep functions small and focused
- Write descriptive commit messages

### Commit Messages

Follow this format:
```
Type: Brief description

Detailed explanation (if needed)

Fixes #issue_number (if applicable)
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:
```
feat: Add support for Cubit state management

Added cubit generator with templates for cubit and state files.
Includes proper imports and follows clean architecture patterns.

Fixes #42
```

### Testing

Before submitting:
```bash
# Run tests (if any)
dart test

# Format code
dart format .

# Analyze code
dart analyze

# Test the tool
dart run bin/arch_generator.dart test_feature --state=bloc
```

## 📁 Project Structure

```
arch_generator/
├── bin/                    # CLI entry point
├── lib/
│   └── src/
│       ├── commands/       # Command handlers
│       ├── config/         # Constants and configs
│       ├── generators/     # File generators
│       ├── models/         # Data models
│       ├── templates/      # Code templates
│       └── utils/          # Utility functions
├── test/                   # Tests
└── docs/                   # Documentation
```

## 🎯 Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/arch_generator.git
cd arch_generator

# Install dependencies
dart pub get

# Test locally
dart run bin/arch_generator.dart --help
```

## ✅ Pull Request Checklist

- [ ] Code follows project style
- [ ] Changes are tested
- [ ] Documentation is updated
- [ ] Commit messages are descriptive
- [ ] No breaking changes (or clearly documented)
- [ ] CHANGELOG.md is updated
- [ ] Code is formatted with `dart format`
- [ ] No analyzer warnings

## 🚀 After Your PR is Merged

- Your contribution will be included in the next release
- You'll be credited in the CHANGELOG
- Thank you for making arch_generator better! 🙏

## 💬 Questions?

Feel free to:
- Open an issue for questions
- Start a discussion in GitHub Discussions
- Contact the maintainers

## 📜 Code of Conduct

Be respectful and constructive. We're all here to learn and improve!

---

**Happy Contributing! 🚀**
