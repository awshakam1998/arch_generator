import 'dart:io';
import 'package:args/args.dart';

import '../config/constants.dart';
import '../generators/datasource_generator.dart';
import '../generators/entity_generator.dart';
import '../generators/folder_generator.dart';
import '../generators/model_generator.dart';
import '../generators/param_generator.dart';
import '../generators/repository_generator.dart';
import '../generators/screen_generator.dart';
import '../generators/usecase_generator.dart';
import '../generators/widget_generator.dart';
import '../generators/state_management/bloc_generator.dart';
import '../generators/state_management/getx_generator.dart';
import '../generators/state_management/provider_generator.dart';
import '../generators/state_management/riverpod_generator.dart';
import '../models/generation_config.dart';
import '../utils/file_utils.dart';
import '../utils/logger.dart';
import '../utils/pubspec_manager.dart';
import '../utils/string_utils.dart';

class GenerateCommand {
  final Logger logger = Logger();
  late final FileUtils fileUtils;
  late final PubspecManager pubspecManager;

  GenerateCommand() {
    fileUtils = FileUtils(logger);
    pubspecManager = PubspecManager(logger);
  }

  Future<void> run(List<String> arguments) async {
    final parser = _createArgParser();

    try {
      final results = parser.parse(arguments);

      // Show help if requested
      if (results['help'] == true || results.rest.isEmpty) {
        _showHelp(parser);
        return;
      }

      // Get feature name from positional argument
      final featureName = results.rest.first;

      // Validate feature name
      if (!_validateFeatureName(featureName)) {
        return;
      }

      // Parse configuration
      final config = _parseConfiguration(results, featureName);

      // Show configuration
      logger.header('Generating Clean Architecture Feature');
      logger.info('Feature: ${config.featureName}');
      logger.info('Output: ${config.outputPath}');
      if (config.stateManagement != null) {
        logger.info('State Management: ${config.stateManagement!.name}');
      }
      logger.divider();

      // Generate files
      await _generateFeature(config);

      // Format generated files
      logger.info('Formatting generated files...');
      await fileUtils.formatDirectory(config.featurePath);

      // Add dependencies to pubspec.yaml
      final skipDeps = results['no-deps'] as bool;
      if (!skipDeps) {
        logger.divider();
        logger.info('Updating pubspec.yaml with required dependencies...');
        await pubspecManager.addDependencies(config);
      }

      logger.divider();
      logger.success('Feature "${config.featureName}" generated successfully!');
      logger.info('');
      logger.info('Next steps:');
      logger.info('  1. Review generated files in ${config.featurePath}');
      logger.info('  2. Implement TODO comments in the generated code');
      if (skipDeps) {
        logger.info('  3. Add necessary dependencies to pubspec.yaml');
      } else {
        logger.info('  3. Run "flutter pub get" to install dependencies');
      }
      logger.info('');
    } catch (e) {
      if (e is FormatException) {
        logger.error('Invalid arguments: ${e.message}');
        logger.info('');
        _showHelp(parser);
      } else {
        logger.error('Error: $e');
      }
      exit(1);
    }
  }

  ArgParser _createArgParser() {
    return ArgParser()
      ..addOption(
        'state',
        abbr: 's',
        help: 'State management solution',
        allowed: ['bloc', 'provider', 'getx', 'riverpod'],
      )
      ..addOption(
        'datasource',
        abbr: 'd',
        help: 'Generate datasource with given name',
      )
      ..addOption(
        'model',
        abbr: 'm',
        help: 'Generate model with given name',
      )
      ..addOption(
        'entity',
        abbr: 'e',
        help: 'Generate entity with given name',
      )
      ..addOption(
        'usecase',
        abbr: 'u',
        help: 'Generate usecase with given name',
      )
      ..addOption(
        'param',
        abbr: 'p',
        help: 'Generate params with given name',
      )
      ..addOption(
        'screen',
        help: 'Generate screen with given name',
      )
      ..addOption(
        'widget',
        help: 'Generate widget with given name',
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'Output directory',
        defaultsTo: Constants.defaultOutputPath,
      )
      ..addFlag(
        'no-deps',
        negatable: false,
        help: 'Skip adding dependencies to pubspec.yaml',
      )
      ..addFlag(
        'help',
        abbr: 'h',
        negatable: false,
        help: 'Show usage information',
      );
  }

  bool _validateFeatureName(String featureName) {
    if (!StringUtils.isValidDartIdentifier(featureName)) {
      logger.error('Invalid feature name: "$featureName"');
      logger.info('Feature name must be a valid Dart identifier:');
      logger.info('  - Start with a letter or underscore');
      logger.info('  - Contain only letters, digits, and underscores');
      logger.info('  - Not be a Dart reserved keyword');
      return false;
    }

    // Recommend lowercase naming
    if (featureName != featureName.toLowerCase()) {
      logger.warn('Feature name should be lowercase: "$featureName"');
      logger.info('Consider using: "${featureName.toLowerCase()}"');
    }

    return true;
  }

  GenerationConfig _parseConfiguration(ArgResults results, String featureName) {
    return GenerationConfig(
      featureName: featureName.toLowerCase(),
      outputPath: results['output'] as String,
      stateManagement: StateManagement.fromString(results['state'] as String?),
      datasourceName: results['datasource'] as String?,
      modelName: results['model'] as String?,
      entityName: results['entity'] as String?,
      usecaseName: results['usecase'] as String?,
      paramName: results['param'] as String?,
      screenName: results['screen'] as String?,
      widgetName: results['widget'] as String?,
    );
  }

  Future<void> _generateFeature(GenerationConfig config) async {
    // 1. Create folder structure
    final folderGenerator = FolderGenerator(fileUtils, logger);
    await folderGenerator.generate(config);

    // 2. Generate repository (always generated)
    final repositoryGenerator = RepositoryGenerator(fileUtils);
    await repositoryGenerator.generate(config);

    // 3. Generate datasource files
    if (config.datasourceName != null) {
      final datasourceGenerator = DatasourceGenerator(fileUtils);
      await datasourceGenerator.generate(config);
    }

    // 4. Generate model files
    if (config.modelName != null) {
      final modelGenerator = ModelGenerator(fileUtils);
      await modelGenerator.generate(config);
    }

    // 5. Generate entity files
    if (config.entityName != null) {
      final entityGenerator = EntityGenerator(fileUtils);
      await entityGenerator.generate(config);
    }

    // 6. Generate usecase files
    if (config.usecaseName != null) {
      final usecaseGenerator = UsecaseGenerator(fileUtils);
      await usecaseGenerator.generate(config);
    }

    // 7. Generate param files
    if (config.paramName != null) {
      final paramGenerator = ParamGenerator(fileUtils);
      await paramGenerator.generate(config);
    }

    // 8. Generate screen files
    if (config.screenName != null) {
      final screenGenerator = ScreenGenerator(fileUtils);
      await screenGenerator.generate(config);
    }

    // 9. Generate widget files
    if (config.widgetName != null) {
      final widgetGenerator = WidgetGenerator(fileUtils);
      await widgetGenerator.generate(config);
    }

    // 10. Generate state management files
    if (config.stateManagement != null) {
      switch (config.stateManagement!) {
        case StateManagement.bloc:
          final blocGenerator = BlocGenerator(fileUtils);
          await blocGenerator.generate(config);
          break;
        case StateManagement.provider:
          final providerGenerator = ProviderGenerator(fileUtils);
          await providerGenerator.generate(config);
          break;
        case StateManagement.getx:
          final getxGenerator = GetxGenerator(fileUtils);
          await getxGenerator.generate(config);
          break;
        case StateManagement.riverpod:
          final riverpodGenerator = RiverpodGenerator(fileUtils);
          await riverpodGenerator.generate(config);
          break;
      }
    }
  }

  void _showHelp(ArgParser parser) {
    print(Constants.helpText);
  }
}
