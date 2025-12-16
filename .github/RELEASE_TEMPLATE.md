# arch_generator v1.0.0 - Initial Release 🎉

A powerful CLI tool to generate Flutter clean architecture feature structures with boilerplate code templates.

## 🌟 Features

### Core Functionality
- ✅ Complete clean architecture folder structure generation
- ✅ Automatic code generation for all layers (Data, Domain, Presentation)
- ✅ Template-based boilerplate code following best practices
- ✅ Automatic code formatting with `dart format`
- ✅ Smart naming convention handling (snake_case, PascalCase)

### State Management Support
- ✅ **Bloc** - Complete bloc/event/state pattern
- ✅ **Provider** - ChangeNotifier pattern
- ✅ **GetX** - Controller and binding
- ✅ **Riverpod** - Provider and StateNotifier

### Generators
- ✅ Datasource (abstract interface + implementation)
- ✅ Model (with JSON serialization)
- ✅ Entity (with Equatable)
- ✅ Repository (interface + implementation)
- ✅ Usecase (with Either pattern)
- ✅ Params (with Equatable)
- ✅ Screen (StatelessWidget)
- ✅ Widget (reusable components)

## 🚀 Quick Start

### Installation

```bash
dart pub global activate --source git https://github.com/awshakam1998/arch_generator.git
```

### Basic Usage

```bash
# Generate basic structure
arch_generator auth

# Generate with Bloc
arch_generator auth --state=bloc --entity=User

# Generate complete feature
arch_generator auth \
  --state=bloc \
  --datasource=AuthDatasource \
  --entity=User \
  --usecase=LoginUsecase \
  --screen=LoginScreen
```

## 📦 What Gets Generated

```
lib/features/auth/
├── data/
│   ├── datasources/
│   │   ├── auth_datasource.dart
│   │   └── auth_datasource_impl.dart
│   ├── models/
│   │   └── auth_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   ├── usecases/
│   │   └── login_usecase.dart
│   └── params/
│       └── login_params.dart
└── presentation/
    ├── screens/
    │   └── login_screen.dart
    ├── widgets/
    └── bloc/
        ├── auth_bloc.dart
        ├── auth_event.dart
        └── auth_state.dart
```

## 📖 Documentation

- [README.md](https://github.com/awshakam1998/arch_generator/blob/main/README.md) - Comprehensive usage guide
- [DEPLOYMENT_GUIDE.md](https://github.com/awshakam1998/arch_generator/blob/main/DEPLOYMENT_GUIDE.md) - Deployment instructions
- [CHANGELOG.md](https://github.com/awshakam1998/arch_generator/blob/main/CHANGELOG.md) - Version history

## 🎯 Use Cases

Perfect for:
- 🏗️ Starting new Flutter projects with clean architecture
- ⚡ Rapidly scaffolding new features
- 📚 Learning clean architecture patterns
- 👥 Team projects requiring consistent structure
- 🎓 Teaching Flutter best practices

## 🔧 Requirements

- Dart SDK: >=3.0.0
- Flutter SDK (for Flutter projects)

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## 📄 License

MIT License - see [LICENSE](https://github.com/awshakam1998/arch_generator/blob/main/LICENSE)

---

**Happy Coding! 🚀**

Made with ❤️ by awshakam
