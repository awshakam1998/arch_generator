import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/data_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class ModelGenerator extends BaseGenerator {
  ModelGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.modelName == null) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => DataTemplates.model;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.modelName!);
    return '${config.dataPath}/${Constants.modelsFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    // Try to infer entity name from model name or use config's entity name
    final entityName = config.entityName ??
        StringUtils.removeCommonSuffixes(config.modelName!);
    final entityFileName = StringUtils.toSnakeCase(entityName);

    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': config.modelName!,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(config.modelName!),
      '{{ENTITY_NAME}}': entityName,
      '{{ENTITY_FILE_NAME}}': entityFileName,
    };
  }
}
