import 'dart:io';
import 'package:path/path.dart' as path;
import '../models/generation_config.dart';
import 'logger.dart';

/// Manages pubspec.yaml dependencies
class PubspecManager {
  final Logger logger;

  PubspecManager(this.logger);

  /// Core dependencies used in templates
  static const Map<String, String> coreDependencies = {
    'equatable': '^2.0.5',
    'dartz': '^0.10.1',
  };

  /// State management dependencies
  static const Map<StateManagement, Map<String, String>> stateManagementDependencies = {
    StateManagement.bloc: {
      'flutter_bloc': '^8.1.6',
      'bloc': '^8.1.4',
    },
    StateManagement.provider: {
      'provider': '^6.1.2',
    },
    StateManagement.getx: {
      'get': '^4.6.6',
    },
    StateManagement.riverpod: {
      'flutter_riverpod': '^2.5.1',
      'riverpod_annotation': '^2.3.5',
    },
  };

  /// Gets all required dependencies based on configuration
  Map<String, String> getRequiredDependencies(GenerationConfig config) {
    final dependencies = <String, String>{};

    // Add core dependencies (always needed for clean architecture)
    dependencies.addAll(coreDependencies);

    // Add state management dependencies if specified
    if (config.stateManagement != null) {
      final stateDeps = stateManagementDependencies[config.stateManagement];
      if (stateDeps != null) {
        dependencies.addAll(stateDeps);
      }
    }

    return dependencies;
  }

  /// Finds the pubspec.yaml file in the current or parent directories
  File? findPubspecFile() {
    var currentDir = Directory.current;

    // Search up to 5 levels up
    for (var i = 0; i < 5; i++) {
      final pubspecPath = path.join(currentDir.path, 'pubspec.yaml');
      final pubspecFile = File(pubspecPath);

      if (pubspecFile.existsSync()) {
        return pubspecFile;
      }

      final parentDir = currentDir.parent;
      if (parentDir.path == currentDir.path) {
        break; // Reached root
      }
      currentDir = parentDir;
    }

    return null;
  }

  /// Adds dependencies to pubspec.yaml
  Future<bool> addDependencies(GenerationConfig config) async {
    final pubspecFile = findPubspecFile();

    if (pubspecFile == null) {
      logger.warn('Could not find pubspec.yaml file');
      logger.info('Please add the following dependencies manually:');
      _printDependencies(config);
      return false;
    }

    try {
      final content = await pubspecFile.readAsString();
      final requiredDeps = getRequiredDependencies(config);

      // Check which dependencies are missing
      final missingDeps = <String, String>{};
      for (final entry in requiredDeps.entries) {
        if (!_hasDependency(content, entry.key)) {
          missingDeps[entry.key] = entry.value;
        }
      }

      if (missingDeps.isEmpty) {
        logger.info('All required dependencies are already present');
        return true;
      }

      // Add missing dependencies
      final updatedContent = _addDependenciesToContent(content, missingDeps);

      if (updatedContent == null) {
        logger.warn('Could not automatically update pubspec.yaml');
        logger.info('Please add the following dependencies manually:');
        _printMissingDependencies(missingDeps);
        return false;
      }

      await pubspecFile.writeAsString(updatedContent);
      logger.success('Added dependencies to pubspec.yaml:');
      for (final dep in missingDeps.keys) {
        logger.detail('  + $dep: ${missingDeps[dep]}');
      }

      logger.info('');
      logger.warn('Run "flutter pub get" to install new dependencies');

      return true;
    } catch (e) {
      logger.error('Failed to update pubspec.yaml: $e');
      logger.info('Please add the following dependencies manually:');
      _printDependencies(config);
      return false;
    }
  }

  /// Checks if a dependency exists in the pubspec content
  bool _hasDependency(String content, String packageName) {
    // Match patterns like "  package_name:" or "  package_name :"
    final pattern = RegExp(r'^\s+' + RegExp.escape(packageName) + r'\s*:', multiLine: true);
    return pattern.hasMatch(content);
  }

  /// Adds dependencies to pubspec.yaml content
  String? _addDependenciesToContent(String content, Map<String, String> dependencies) {
    // Find the dependencies: section
    final dependenciesPattern = RegExp(r'^dependencies:\s*$', multiLine: true);
    final match = dependenciesPattern.firstMatch(content);

    if (match == null) {
      return null;
    }

    // Build the dependency strings
    final depStrings = dependencies.entries
        .map((e) => '  ${e.key}: ${e.value}')
        .join('\n');

    // Find where to insert (after dependencies: line)
    final insertPosition = match.end;

    // Insert new dependencies after "dependencies:" line
    final updatedContent =
        '${content.substring(0, insertPosition)}\n  # Added by flutter_arch_generator\n$depStrings\n${content.substring(insertPosition)}';

    return updatedContent;
  }

  /// Prints all required dependencies
  void _printDependencies(GenerationConfig config) {
    final deps = getRequiredDependencies(config);
    logger.info('');
    logger.info('dependencies:');
    for (final entry in deps.entries) {
      logger.info('  ${entry.key}: ${entry.value}');
    }
    logger.info('');
  }

  /// Prints missing dependencies
  void _printMissingDependencies(Map<String, String> dependencies) {
    logger.info('');
    for (final entry in dependencies.entries) {
      logger.info('  ${entry.key}: ${entry.value}');
    }
    logger.info('');
  }

  /// Gets a formatted string of dependencies for display
  String getDependenciesInfo(GenerationConfig config) {
    final deps = getRequiredDependencies(config);
    final buffer = StringBuffer();

    buffer.writeln('Required dependencies:');
    for (final entry in deps.entries) {
      buffer.writeln('  ${entry.key}: ${entry.value}');
    }

    return buffer.toString();
  }
}

