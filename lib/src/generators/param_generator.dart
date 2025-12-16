import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/domain_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class ParamGenerator extends BaseGenerator {
  ParamGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.paramName == null) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => DomainTemplates.params;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.paramName!);
    return '${config.domainPath}/${Constants.paramsFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': config.paramName!,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(config.paramName!),
    };
  }
}
