enum StateManagement {
  bloc,
  provider,
  getx,
  riverpod;

  static StateManagement? fromString(String? value) {
    if (value == null) return null;
    try {
      return StateManagement.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  String get folderName {
    switch (this) {
      case StateManagement.bloc:
        return 'bloc';
      case StateManagement.provider:
        return 'provider';
      case StateManagement.getx:
        return 'getx';
      case StateManagement.riverpod:
        return 'riverpod';
    }
  }
}

class GenerationConfig {
  final String featureName;
  final String outputPath;
  final StateManagement? stateManagement;
  final String? datasourceName;
  final String? modelName;
  final String? entityName;
  final String? usecaseName;
  final String? paramName;
  final String? screenName;
  final String? widgetName;

  GenerationConfig({
    required this.featureName,
    required this.outputPath,
    this.stateManagement,
    this.datasourceName,
    this.modelName,
    this.entityName,
    this.usecaseName,
    this.paramName,
    this.screenName,
    this.widgetName,
  });

  /// Returns the base feature path
  String get featurePath => '$outputPath/$featureName';

  /// Returns the data layer path
  String get dataPath => '$featurePath/data';

  /// Returns the domain layer path
  String get domainPath => '$featurePath/domain';

  /// Returns the presentation layer path
  String get presentationPath => '$featurePath/presentation';

  /// Returns true if any generation option is specified
  bool get hasGenerationOptions {
    return datasourceName != null ||
        modelName != null ||
        entityName != null ||
        usecaseName != null ||
        paramName != null ||
        screenName != null ||
        widgetName != null ||
        stateManagement != null;
  }

  @override
  String toString() {
    return 'GenerationConfig(\n'
        '  featureName: $featureName,\n'
        '  outputPath: $outputPath,\n'
        '  stateManagement: $stateManagement,\n'
        '  datasourceName: $datasourceName,\n'
        '  modelName: $modelName,\n'
        '  entityName: $entityName,\n'
        '  usecaseName: $usecaseName,\n'
        '  paramName: $paramName,\n'
        '  screenName: $screenName,\n'
        '  widgetName: $widgetName\n'
        ')';
  }
}
