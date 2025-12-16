import '../../models/generation_config.dart';
import '../../templates/state_templates.dart';
import '../../utils/string_utils.dart';
import '../base_generator.dart';

class BlocGenerator extends BaseGenerator {
  BlocGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.stateManagement != StateManagement.bloc) return;

    await _generateBlocFile(config);
    await _generateEventFile(config);
    await _generateStateFile(config);
  }

  Future<void> _generateBlocFile(GenerationConfig config) async {
    final className = StringUtils.toPascalCase(config.featureName);
    final fileName = '${config.featureName}_bloc';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
      '{{FILE_NAME}}': fileName,
    };

    final content = StateTemplates.bloc;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{FEATURE_NAME}}', variables['{{FEATURE_NAME}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  Future<void> _generateEventFile(GenerationConfig config) async {
    final className = StringUtils.toPascalCase(config.featureName);
    final fileName = '${config.featureName}_event';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
    };

    final content = StateTemplates.blocEvent;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{FEATURE_NAME}}', variables['{{FEATURE_NAME}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  Future<void> _generateStateFile(GenerationConfig config) async {
    final className = StringUtils.toPascalCase(config.featureName);
    final fileName = '${config.featureName}_state';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
    };

    final content = StateTemplates.blocState;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{FEATURE_NAME}}', variables['{{FEATURE_NAME}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  @override
  String getTemplate() => StateTemplates.bloc;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = '${config.featureName}_bloc';
    return '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': StringUtils.toPascalCase(config.featureName),
      '{{FILE_NAME}}': '${config.featureName}_bloc',
    };
  }
}
