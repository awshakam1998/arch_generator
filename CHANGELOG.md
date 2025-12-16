# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2024-12-16

### Added
- Initial release of arch_generator
- Clean architecture folder structure generation
- Support for Data, Domain, and Presentation layers
- Datasource generator (abstract interface + implementation)
- Model generator with JSON serialization templates
- Entity generator with Equatable
- Repository generator (interface + implementation)
- Usecase generator with Either pattern
- Params generator
- Screen generator (StatelessWidget)
- Widget generator
- State management support:
  - Bloc (bloc, event, state files)
  - Provider (ChangeNotifier)
  - GetX (controller + binding)
  - Riverpod (provider + notifier)
- Automatic code formatting
- Colored CLI output
- Input validation
- Help command
- Comprehensive documentation

### Features
- Template-based code generation
- Clean architecture best practices
- Multiple state management solutions
- Customizable output directory
- Optional component generation
- Automatic naming convention handling (snake_case, PascalCase)

### Documentation
- Comprehensive README with examples
- Detailed usage instructions
- Deployment guide
- Code templates with TODO comments
