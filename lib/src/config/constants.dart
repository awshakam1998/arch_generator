class Constants {
  // Default paths
  static const String defaultOutputPath = 'lib/features';

  // Folder names
  static const String dataFolder = 'data';
  static const String domainFolder = 'domain';
  static const String presentationFolder = 'presentation';

  // Data layer folders
  static const String datasourcesFolder = 'datasources';
  static const String modelsFolder = 'models';
  static const String dataRepositoriesFolder = 'repositories';

  // Domain layer folders
  static const String entitiesFolder = 'entities';
  static const String domainRepositoriesFolder = 'repositories';
  static const String usecasesFolder = 'usecases';
  static const String paramsFolder = 'params';

  // Presentation layer folders
  static const String screensFolder = 'screens';
  static const String widgetsFolder = 'widgets';

  // State management folder names
  static const String blocFolder = 'bloc';
  static const String providerFolder = 'provider';
  static const String getxFolder = 'getx';
  static const String riverpodFolder = 'riverpod';

  // File suffixes
  static const String datasourceSuffix = '_datasource';
  static const String datasourceImplSuffix = '_datasource_impl';
  static const String modelSuffix = '_model';
  static const String entitySuffix = '_entity';
  static const String repositorySuffix = '_repository';
  static const String repositoryImplSuffix = '_repository_impl';
  static const String usecaseSuffix = '_usecase';
  static const String paramsSuffix = '_params';
  static const String screenSuffix = '_screen';
  static const String widgetSuffix = '_widget';
  static const String blocFileSuffix = '_bloc';
  static const String eventSuffix = '_event';
  static const String stateSuffix = '_state';
  static const String controllerSuffix = '_controller';
  static const String providerSuffix = '_provider';

  // Template variable names
  static const String featureNameVar = '{{FEATURE_NAME}}';
  static const String featureNamePascalVar = '{{FEATURE_NAME_PASCAL}}';
  static const String featureNameCamelVar = '{{FEATURE_NAME_CAMEL}}';
  static const String classNameVar = '{{CLASS_NAME}}';
  static const String fileNameVar = '{{FILE_NAME}}';
  static const String entityNameVar = '{{ENTITY_NAME}}';
  static const String entityFileNameVar = '{{ENTITY_FILE_NAME}}';
  static const String modelNameVar = '{{MODEL_NAME}}';
  static const String modelFileNameVar = '{{MODEL_FILE_NAME}}';
  static const String repositoryNameVar = '{{REPOSITORY_NAME}}';
  static const String repositoryFileNameVar = '{{REPOSITORY_FILE_NAME}}';
  static const String datasourceNameVar = '{{DATASOURCE_NAME}}';
  static const String datasourceFileNameVar = '{{DATASOURCE_FILE_NAME}}';
  static const String usecaseNameVar = '{{USECASE_NAME}}';
  static const String paramNameVar = '{{PARAM_NAME}}';
  static const String methodNameVar = '{{METHOD_NAME}}';
  static const String blocFileNameVar = '{{BLOC_FILE_NAME}}';
  static const String screenTitleVar = '{{SCREEN_TITLE}}';

  // Help text
  static const String helpText = '''
arch_generator - Flutter Clean Architecture Feature Generator

Usage:
  arch_generator <feature_name> [options]

Arguments:
  feature_name    The name of the feature to generate (required)

Options:
  --state=<type>          State management type (bloc, provider, getx, riverpod)
  --datasource=<name>     Generate datasource with given name
  --model=<name>          Generate model with given name
  --entity=<name>         Generate entity with given name
  --usecase=<name>        Generate usecase with given name
  --param=<name>          Generate params with given name
  --screen=<name>         Generate screen with given name
  --widget=<name>         Generate widget with given name
  --output=<path>         Output directory (default: lib/features)
  --help, -h              Show this help message

Examples:
  # Generate basic folder structure
  arch_generator auth

  # Generate with state management
  arch_generator auth --state=bloc

  # Generate complete feature
  arch_generator auth --state=bloc --datasource=AuthDatasource --entity=User --usecase=LoginUsecase

  # Generate with custom output
  arch_generator auth --output=lib/custom_features --state=provider
''';
}
