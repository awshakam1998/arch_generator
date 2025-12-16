import '../config/constants.dart';
import '../models/generation_config.dart';
import '../utils/file_utils.dart';
import '../utils/logger.dart';

class FolderGenerator {
  final FileUtils fileUtils;
  final Logger logger;

  FolderGenerator(this.fileUtils, this.logger);

  /// Generates the complete folder structure for a feature
  Future<void> generate(GenerationConfig config) async {
    logger.info('Creating folder structure for feature: ${config.featureName}');

    // Create base feature folders
    await _createDataFolders(config);
    await _createDomainFolders(config);
    await _createPresentationFolders(config);

    logger.success('Folder structure created successfully');
  }

  /// Creates data layer folders
  Future<void> _createDataFolders(GenerationConfig config) async {
    final basePath = config.dataPath;

    await fileUtils.createDirectory('$basePath/${Constants.datasourcesFolder}');
    await fileUtils.createDirectory('$basePath/${Constants.modelsFolder}');
    await fileUtils.createDirectory('$basePath/${Constants.dataRepositoriesFolder}');
  }

  /// Creates domain layer folders
  Future<void> _createDomainFolders(GenerationConfig config) async {
    final basePath = config.domainPath;

    await fileUtils.createDirectory('$basePath/${Constants.entitiesFolder}');
    await fileUtils.createDirectory('$basePath/${Constants.domainRepositoriesFolder}');
    await fileUtils.createDirectory('$basePath/${Constants.usecasesFolder}');
    await fileUtils.createDirectory('$basePath/${Constants.paramsFolder}');
  }

  /// Creates presentation layer folders
  Future<void> _createPresentationFolders(GenerationConfig config) async {
    final basePath = config.presentationPath;

    await fileUtils.createDirectory('$basePath/${Constants.screensFolder}');
    await fileUtils.createDirectory('$basePath/${Constants.widgetsFolder}');

    // Create state management folder if specified
    if (config.stateManagement != null) {
      final stateFolder = config.stateManagement!.folderName;
      await fileUtils.createDirectory('$basePath/$stateFolder');
    }
  }
}
