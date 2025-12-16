import '../../models/generation_config.dart';
import '../../templates/state_templates.dart';
import '../../utils/string_utils.dart';
import '../base_generator.dart';

class ProviderGenerator extends BaseGenerator {
  ProviderGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.stateManagement != StateManagement.provider) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => StateTemplates.provider;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = '${config.featureName}_provider';
    return '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': StringUtils.toPascalCase(config.featureName),
      '{{FILE_NAME}}': '${config.featureName}_provider',
    };
  }
}
