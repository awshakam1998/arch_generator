import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/domain_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class EntityGenerator extends BaseGenerator {
  EntityGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.entityName == null) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => DomainTemplates.entity;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.entityName!);
    return '${config.domainPath}/${Constants.entitiesFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': config.entityName!,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(config.entityName!),
    };
  }
}
