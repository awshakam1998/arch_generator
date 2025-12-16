import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/presentation_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class ScreenGenerator extends BaseGenerator {
  ScreenGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.screenName == null) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => PresentationTemplates.screen;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.screenName!);
    return '${config.presentationPath}/${Constants.screensFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    // Extract screen title from class name
    final className = config.screenName!;
    final screenTitle = StringUtils.removeCommonSuffixes(className);

    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(className),
      '{{SCREEN_TITLE}}': screenTitle,
    };
  }
}
