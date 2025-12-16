import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/presentation_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class WidgetGenerator extends BaseGenerator {
  WidgetGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.widgetName == null) return;

    final outputPath = getOutputPath(config);
    await renderAndWrite(config, getTemplate(), outputPath);
  }

  @override
  String getTemplate() => PresentationTemplates.widget;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.widgetName!);
    return '${config.presentationPath}/${Constants.widgetsFolder}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': config.widgetName!,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(config.widgetName!),
    };
  }
}
