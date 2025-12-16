# arch_generator

A powerful CLI tool to generate Flutter clean architecture feature structures with boilerplate code templates. This tool helps you quickly scaffold features following clean architecture principles with support for multiple state management solutions.

## Features

- 🏗️ **Complete Clean Architecture Structure**: Automatically generates Data, Domain, and Presentation layers
- 🎯 **Multiple State Management**: Support for Bloc, Provider, GetX, and Riverpod
- 📝 **Boilerplate Code**: Generates ready-to-use code templates following best practices
- ⚡ **Fast & Easy**: Create a complete feature structure in seconds
- 🎨 **Customizable**: Generate only the components you need with optional flags

## Installation

### Local Installation

1. Clone or download this package to your local machine
2. Navigate to the package directory:
   ```bash
   cd arch_generator
   ```

3. Install dependencies:
   ```bash
   dart pub get
   ```

4. Run the tool:
   ```bash
   dart run bin/arch_generator.dart <feature_name> [options]
   ```

### Global Installation (Optional)

To use the tool from anywhere:

```bash
dart pub global activate --source path .
arch_generator <feature_name> [options]
```

## Usage

### Basic Command Structure

```bash
dart run bin/arch_generator.dart <feature_name> [options]
```

### Available Options

| Option | Shorthand | Description | Values |
|--------|-----------|-------------|--------|
| `--state` | `-s` | State management solution | `bloc`, `provider`, `getx`, `riverpod` |
| `--datasource` | `-d` | Generate datasource with given name | Any PascalCase name |
| `--model` | `-m` | Generate model with given name | Any PascalCase name |
| `--entity` | `-e` | Generate entity with given name | Any PascalCase name |
| `--usecase` | `-u` | Generate usecase with given name | Any PascalCase name |
| `--param` | `-p` | Generate params with given name | Any PascalCase name |
| `--screen` | | Generate screen with given name | Any PascalCase name |
| `--widget` | | Generate widget with given name | Any PascalCase name |
| `--output` | `-o` | Output directory | Default: `lib/features` |
| `--help` | `-h` | Show help message | - |

## Examples

### 1. Generate Basic Folder Structure

```bash
dart run bin/arch_generator.dart auth
```

Creates:
```
lib/features/auth/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   ├── usecases/
│   └── params/
└── presentation/
    ├── screens/
    └── widgets/
```

### 2. Generate with State Management

```bash
dart run bin/arch_generator.dart auth --state=bloc
```

Additionally creates:
```
lib/features/auth/presentation/bloc/
├── auth_bloc.dart
├── auth_event.dart
└── auth_state.dart
```

### 3. Generate Complete Feature with Bloc

```bash
dart run bin/arch_generator.dart auth \
  --state=bloc \
  --datasource=AuthDatasource \
  --model=AuthModel \
  --entity=User \
  --usecase=LoginUsecase \
  --param=LoginParams \
  --screen=LoginScreen \
  --widget=LoginForm
```

Creates a complete authentication feature with:
- Data layer: `AuthDatasource`, `AuthDatasourceImpl`, `AuthModel`, `AuthRepositoryImpl`
- Domain layer: `User` entity, `AuthRepository`, `LoginUsecase`, `LoginParams`
- Presentation layer: `LoginScreen`, `LoginForm`, Bloc files

### 4. Generate with Provider

```bash
dart run bin/arch_generator.dart product \
  --state=provider \
  --datasource=ProductDatasource \
  --entity=Product \
  --screen=ProductListScreen
```

### 5. Generate with GetX

```bash
dart run bin/arch_generator.dart cart \
  --state=getx \
  --entity=CartItem \
  --usecase=AddToCartUsecase \
  --screen=CartScreen
```

### 6. Generate with Riverpod

```bash
dart run bin/arch_generator.dart settings \
  --state=riverpod \
  --entity=Settings \
  --screen=SettingsScreen
```

### 7. Custom Output Directory

```bash
dart run bin/arch_generator.dart profile \
  --output=lib/custom_features \
  --state=bloc \
  --entity=Profile
```

## Generated File Structure

### Complete Feature Structure Example

```
lib/features/auth/
├── data/
│   ├── datasources/
│   │   ├── auth_datasource.dart           # Abstract interface
│   │   └── auth_datasource_impl.dart      # Implementation
│   ├── models/
│   │   └── auth_model.dart                # Model extending entity
│   └── repositories/
│       └── auth_repository_impl.dart      # Repository implementation
├── domain/
│   ├── entities/
│   │   └── user.dart                      # Domain entity
│   ├── repositories/
│   │   └── auth_repository.dart           # Repository interface
│   ├── usecases/
│   │   └── login_usecase.dart             # Business logic
│   └── params/
│       └── login_params.dart              # Usecase parameters
└── presentation/
    ├── screens/
    │   └── login_screen.dart              # UI screen
    ├── widgets/
    │   └── login_form.dart                # Reusable widgets
    └── bloc/                              # State management
        ├── auth_bloc.dart
        ├── auth_event.dart
        └── auth_state.dart
```

## Naming Conventions

The tool automatically handles naming conventions:

- **Feature names**: Use lowercase (e.g., `auth`, `user`, `product`)
- **Class names**: Use PascalCase (e.g., `AuthDatasource`, `LoginUsecase`)
- **File names**: Automatically converted to snake_case (e.g., `auth_datasource.dart`)

## State Management Support

### Bloc
Generates:
- `{feature}_bloc.dart` - Main bloc class
- `{feature}_event.dart` - Event definitions
- `{feature}_state.dart` - State definitions

### Provider
Generates:
- `{feature}_provider.dart` - ChangeNotifier provider

### GetX
Generates:
- `{feature}_controller.dart` - GetX controller
- `{feature}_binding.dart` - GetX binding

### Riverpod
Generates:
- `{feature}_provider.dart` - Riverpod providers
- `{feature}_notifier.dart` - StateNotifier

## Next Steps After Generation

After generating a feature:

1. **Review Generated Files**: Check all generated files in the feature directory
2. **Implement TODOs**: Fill in the TODO comments with your business logic
3. **Add Dependencies**: Add required packages to your `pubspec.yaml`:
   - For clean architecture: `dartz`, `equatable`
   - For Bloc: `flutter_bloc`
   - For Provider: `provider`
   - For GetX: `get`
   - For Riverpod: `flutter_riverpod`

4. **Create Core Files**: Some templates reference core files like:
   - `lib/core/error/failures.dart`
   - `lib/core/usecases/usecase.dart`

5. **Format Code**: Code is automatically formatted using `dart format`

## Example: Complete Workflow

```bash
# 1. Generate auth feature with Bloc
dart run bin/arch_generator.dart auth \
  --state=bloc \
  --datasource=AuthDatasource \
  --model=UserModel \
  --entity=User \
  --usecase=LoginUsecase \
  --param=LoginParams \
  --screen=LoginScreen

# 2. Add dependencies to pubspec.yaml
# dependencies:
#   flutter_bloc: ^8.1.3
#   equatable: ^2.0.5
#   dartz: ^0.10.1

# 3. Implement the business logic in generated files

# 4. Run the app
flutter run
```

## Tips

- Start with a basic structure and add components as needed
- Use descriptive names for custom components (e.g., `GetUserUsecase` instead of just `Usecase`)
- Keep feature names simple and lowercase
- Review the generated TODO comments for implementation guidance

## Requirements

- Dart SDK: >=3.0.0
- For Flutter projects: Flutter SDK

## Troubleshooting

**Issue**: "Invalid feature name"
- **Solution**: Ensure feature name is lowercase and contains only letters, numbers, and underscores

**Issue**: "Command not found"
- **Solution**: Run from the package directory or install globally

**Issue**: Files not formatted correctly
- **Solution**: Run `dart format .` manually in the generated feature directory

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

## License

This project is open source and available under the MIT License.
