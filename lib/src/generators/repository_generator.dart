import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/data_templates.dart';
import '../templates/domain_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class RepositoryGenerator extends BaseGenerator {
  RepositoryGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    // Always generate repository interface in domain layer
    await _generateInterface(config);

    // Generate repository implementation in data layer if datasource is specified
    if (config.datasourceName != null) {
      await _generateImplementation(config);
    }
  }

  Future<void> _generateInterface(GenerationConfig config) async {
    final repositoryName = '${StringUtils.toPascalCase(config.featureName)}Repository';
    final fileName = '${config.featureName}${Constants.repositorySuffix}';

    final entityName = config.entityName ?? StringUtils.toPascalCase(config.featureName);
    final entityFileName = StringUtils.toSnakeCase(entityName);

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': repositoryName,
      '{{FILE_NAME}}': fileName,
      '{{ENTITY_NAME}}': entityName,
      '{{ENTITY_FILE_NAME}}': entityFileName,
    };

    final content = DomainTemplates.repositoryInterface;
    final outputPath = '${config.domainPath}/${Constants.domainRepositoriesFolder}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{ENTITY_NAME}}', variables['{{ENTITY_NAME}}']!)
        .replaceAll('{{ENTITY_FILE_NAME}}', variables['{{ENTITY_FILE_NAME}}']!)
        .replaceAll('{{FEATURE_NAME_PASCAL}}', variables['{{FEATURE_NAME_PASCAL}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  Future<void> _generateImplementation(GenerationConfig config) async {
    final repositoryName = '${StringUtils.toPascalCase(config.featureName)}Repository';
    final implName = '${repositoryName}Impl';
    final fileName = '${config.featureName}${Constants.repositoryImplSuffix}';

    final entityName = config.entityName ?? StringUtils.toPascalCase(config.featureName);
    final entityFileName = StringUtils.toSnakeCase(entityName);

    final datasourceName = config.datasourceName!;
    final datasourceFileName = StringUtils.toSnakeCase(datasourceName);

    final repositoryFileName = '${config.featureName}${Constants.repositorySuffix}';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': implName,
      '{{REPOSITORY_NAME}}': repositoryName,
      '{{REPOSITORY_FILE_NAME}}': repositoryFileName,
      '{{ENTITY_NAME}}': entityName,
      '{{ENTITY_FILE_NAME}}': entityFileName,
      '{{DATASOURCE_NAME}}': datasourceName,
      '{{DATASOURCE_FILE_NAME}}': datasourceFileName,
    };

    final content = DataTemplates.repositoryImplementation;
    final outputPath = '${config.dataPath}/${Constants.dataRepositoriesFolder}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{REPOSITORY_NAME}}', variables['{{REPOSITORY_NAME}}']!)
        .replaceAll('{{REPOSITORY_FILE_NAME}}', variables['{{REPOSITORY_FILE_NAME}}']!)
        .replaceAll('{{ENTITY_NAME}}', variables['{{ENTITY_NAME}}']!)
        .replaceAll('{{ENTITY_FILE_NAME}}', variables['{{ENTITY_FILE_NAME}}']!)
        .replaceAll('{{DATASOURCE_NAME}}', variables['{{DATASOURCE_NAME}}']!)
        .replaceAll('{{DATASOURCE_FILE_NAME}}', variables['{{DATASOURCE_FILE_NAME}}']!)
        .replaceAll('{{FEATURE_NAME_PASCAL}}', variables['{{FEATURE_NAME_PASCAL}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  @override
  String getTemplate() => DomainTemplates.repositoryInterface;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = '${config.featureName}${Constants.repositorySuffix}';
    return '${config.domainPath}/${Constants.domainRepositoriesFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': '${StringUtils.toPascalCase(config.featureName)}Repository',
    };
  }
}
