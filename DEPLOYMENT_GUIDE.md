# Deployment & Usage Guide

This guide shows you how to upload and use the arch_generator package in any project.

## 📦 Option 1: Publish to pub.dev (Official Package Registry)

### Prerequisites
- A Google account for pub.dev
- Git repository (GitHub, GitLab, etc.)

### Steps:

#### 1. Update Package Information

✅ Already done! Your `pubspec.yaml` is configured.

Update the URLs in `pubspec.yaml` with your actual GitHub repository:
- Replace `yourusername` with your GitHub username
- Replace `arch_generator` with your repository name (if different)

#### 2. Create GitHub Repository

```bash
cd arch_generator

# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: arch_generator v1.0.0"

# Add remote (replace with your repo URL)
git remote add origin https://github.com/yourusername/arch_generator.git

# Push to GitHub
git branch -M main
git push -u origin main
```

#### 3. Validate Package

```bash
# Check for issues
dart pub publish --dry-run
```

This will check:
- Package name availability
- File structure
- pubspec.yaml validity
- Missing files

#### 4. Publish to pub.dev

```bash
dart pub publish
```

Follow the prompts to:
1. Authenticate with your Google account
2. Confirm publication

#### 5. Use in Any Project

Once published, anyone can use it:

```bash
# Activate globally
dart pub global activate arch_generator

# Use anywhere
arch_generator auth --state=bloc
```

---

## 🔗 Option 2: Use from GitHub (Without Publishing to pub.dev)

If you don't want to publish publicly, you can use directly from GitHub.

### Steps:

#### 1. Push to GitHub

```bash
cd arch_generator
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/arch_generator.git
git push -u origin main
```

#### 2. Tag a Version (Optional but Recommended)

```bash
git tag v1.0.0
git push origin v1.0.0
```

#### 3. Use in Any Project

In your Flutter project's `pubspec.yaml`:

```yaml
dev_dependencies:
  arch_generator:
    git:
      url: https://github.com/yourusername/arch_generator.git
      ref: v1.0.0  # or use 'main' for latest
```

Then install:

```bash
dart pub get

# Use it
dart run arch_generator auth --state=bloc
```

#### For Global Installation from GitHub:

```bash
dart pub global activate --source git https://github.com/yourusername/arch_generator.git

# Use anywhere
arch_generator auth --state=bloc
```

---

## 💻 Option 3: Use from Local Path

Perfect for development or private use without uploading anywhere.

### Method A: Global Activation (Use Anywhere)

```bash
# From the package directory
cd /path/to/arch_generator
dart pub global activate --source path .

# Now use anywhere
cd /any/flutter/project
arch_generator auth --state=bloc
```

### Method B: Project Dependency

In your Flutter project's `pubspec.yaml`:

```yaml
dev_dependencies:
  arch_generator:
    path: /absolute/path/to/arch_generator
```

Or use relative path:

```yaml
dev_dependencies:
  arch_generator:
    path: ../arch_generator
```

Then use:

```bash
dart pub get
dart run arch_generator auth --state=bloc
```

---

## 🏢 Option 4: Private Git Repository (For Teams)

If you're using a private Git server or GitLab/Bitbucket:

### In pubspec.yaml:

```yaml
dev_dependencies:
  arch_generator:
    git:
      url: https://gitlab.com/yourusername/arch_generator.git
      ref: main
```

For private repositories with authentication:

```yaml
dev_dependencies:
  arch_generator:
    git:
      url: git@github.com:yourusername/arch_generator.git
      ref: v1.0.0
```

Make sure you have SSH keys configured for authentication.

---

## 🎯 Recommended Approach

### For Personal/Team Use:
✅ **Option 2 (GitHub)** or **Option 3 (Local Path)**
- Quick to set up
- No need for pub.dev account
- Easy to update

### For Public Sharing:
✅ **Option 1 (pub.dev)**
- Official and discoverable
- Easier for others to use
- Versioning support
- Better documentation visibility

---

## 📝 Quick Start Guide After Installation

Once installed globally:

```bash
# Generate basic structure
arch_generator auth

# With Bloc
arch_generator auth --state=bloc --entity=User

# Complete feature
arch_generator auth \
  --state=bloc \
  --datasource=AuthDatasource \
  --entity=User \
  --usecase=LoginUsecase \
  --screen=LoginScreen
```

---

## 🔄 Updating the Package

### If Published to pub.dev:

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1
   ```

2. Update `CHANGELOG.md`:
   ```markdown
   ## 1.0.1
   - Fixed bug in bloc generator
   - Added new templates
   ```

3. Publish update:
   ```bash
   dart pub publish
   ```

4. Users update with:
   ```bash
   dart pub global activate arch_generator
   ```

### If Using from GitHub:

1. Make changes and commit:
   ```bash
   git add .
   git commit -m "Update: Fixed bloc generator"
   git push
   ```

2. Tag new version:
   ```bash
   git tag v1.0.1
   git push origin v1.0.1
   ```

3. Users update by changing version in their `pubspec.yaml` or:
   ```bash
   dart pub global activate --source git https://github.com/yourusername/arch_generator.git
   ```

---

## 🐛 Troubleshooting

### "Package not found"
- Check internet connection
- Verify package name spelling
- For GitHub: ensure repository is public or SSH keys are configured

### "Version conflict"
- Update Dart SDK: `flutter upgrade`
- Check `pubspec.yaml` constraints

### "Permission denied" (macOS/Linux)
```bash
sudo dart pub global activate arch_generator
```

### Changes not reflecting
```bash
# Deactivate and reactivate
dart pub global deactivate arch_generator
dart pub global activate arch_generator
```

---

## 📊 Comparison Table

| Method | Pros | Cons | Best For |
|--------|------|------|----------|
| **pub.dev** | Official, discoverable, easy updates | Requires Google account, public | Public packages |
| **GitHub** | Simple, private options, version control | Requires Git knowledge | Teams, private use |
| **Local Path** | Instant, no upload needed | Not portable | Development, testing |
| **Private Git** | Private, team access, version control | Setup complexity | Enterprise teams |

---

## 🎓 Example Workflow

### For Publishing to pub.dev:

```bash
# 1. Prepare package
cd arch_generator
dart pub publish --dry-run

# 2. Create GitHub repo and push
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/arch_generator.git
git push -u origin main

# 3. Publish
dart pub publish

# 4. Install globally
dart pub global activate arch_generator

# 5. Use in any project
cd ~/my_flutter_app
arch_generator auth --state=bloc
```

### For Using Locally (Quickest):

```bash
# 1. Activate from current directory
cd arch_generator
dart pub global activate --source path .

# 2. Use immediately
cd ~/my_flutter_app
arch_generator auth --state=bloc
```

---

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section above
2. Run with verbose flag: `dart --verbose run arch_generator ...`
3. Check GitHub issues (if published)
4. Review the README.md for usage examples

---

## ✅ Checklist Before Publishing

- [ ] Updated `pubspec.yaml` with repository URL
- [ ] Created LICENSE file
- [ ] Updated CHANGELOG.md
- [ ] Comprehensive README.md
- [ ] Ran `dart pub publish --dry-run` successfully
- [ ] Tested package locally
- [ ] Created GitHub repository
- [ ] Pushed to GitHub
- [ ] All tests pass (if any)
- [ ] Documentation is complete
