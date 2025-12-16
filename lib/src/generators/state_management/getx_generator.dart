import '../../models/generation_config.dart';
import '../../templates/state_templates.dart';
import '../../utils/string_utils.dart';
import '../base_generator.dart';

class GetxGenerator extends BaseGenerator {
  GetxGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.stateManagement != StateManagement.getx) return;

    await _generateController(config);
    await _generateBinding(config);
  }

  Future<void> _generateController(GenerationConfig config) async {
    final className = StringUtils.toPascalCase(config.featureName);
    final fileName = '${config.featureName}_controller';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
      '{{FILE_NAME}}': fileName,
    };

    final content = StateTemplates.getxController;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{FEATURE_NAME_PASCAL}}', variables['{{FEATURE_NAME_PASCAL}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  Future<void> _generateBinding(GenerationConfig config) async {
    final className = StringUtils.toPascalCase(config.featureName);
    final controllerFileName = '${config.featureName}_controller';
    final fileName = '${config.featureName}_binding';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
      '{{CONTROLLER_NAME}}': '${className}Controller',
      '{{CONTROLLER_FILE_NAME}}': controllerFileName,
    };

    final content = StateTemplates.getxBinding;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{CONTROLLER_NAME}}', variables['{{CONTROLLER_NAME}}']!)
        .replaceAll('{{CONTROLLER_FILE_NAME}}', variables['{{CONTROLLER_FILE_NAME}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  @override
  String getTemplate() => StateTemplates.getxController;

  @override
  String getOutputPath(GenerationConfig config) {
    final fileName = '${config.featureName}_controller';
    return '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';
  }

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': StringUtils.toPascalCase(config.featureName),
      '{{FILE_NAME}}': '${config.featureName}_controller',
    };
  }
}
