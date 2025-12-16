import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/domain_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class UsecaseGenerator extends BaseGenerator {
  UsecaseGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.usecaseName == null) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => DomainTemplates.usecase;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.usecaseName!);
    return '${config.domainPath}/${Constants.usecasesFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    final entityName = config.entityName ?? StringUtils.toPascalCase(config.featureName);
    final entityFileName = StringUtils.toSnakeCase(entityName);

    final paramName = config.paramName ?? 'NoParams';
    final paramFileName = StringUtils.toSnakeCase(paramName);

    final repositoryName = '${StringUtils.toPascalCase(config.featureName)}Repository';
    final repositoryFileName = '${config.featureName}${Constants.repositorySuffix}';

    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': config.usecaseName!,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(config.usecaseName!),
      '{{ENTITY_NAME}}': entityName,
      '{{ENTITY_FILE_NAME}}': entityFileName,
      '{{PARAM_NAME}}': paramName,
      '{{PARAM_FILE_NAME}}': paramFileName,
      '{{REPOSITORY_NAME}}': repositoryName,
      '{{REPOSITORY_FILE_NAME}}': repositoryFileName,
    };
  }
}
