import '../../models/generation_config.dart';
import '../../templates/state_templates.dart';
import '../../utils/string_utils.dart';
import '../base_generator.dart';

class RiverpodGenerator extends BaseGenerator {
  RiverpodGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.stateManagement != StateManagement.riverpod) return;

    await _generateProvider(config);
    await _generateNotifier(config);
  }

  Future<void> _generateProvider(GenerationConfig config) async {
    final entityName = config.entityName ?? StringUtils.toPascalCase(config.featureName);
    final fileName = '${config.featureName}_provider';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': StringUtils.toPascalCase(config.featureName),
      '{{ENTITY_NAME}}': entityName,
    };

    final content = StateTemplates.riverpodProvider;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{FEATURE_NAME_CAMEL}}', variables['{{FEATURE_NAME_CAMEL}}']!)
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{ENTITY_NAME}}', variables['{{ENTITY_NAME}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  Future<void> _generateNotifier(GenerationConfig config) async {
    final className = StringUtils.toPascalCase(config.featureName);
    final fileName = '${config.featureName}_notifier';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': className,
    };

    final content = StateTemplates.riverpodNotifier;
    final outputPath = '${config.presentationPath}/${config.stateManagement!.folderName}/$fileName.dart';

    final renderedContent = content
        .replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{FEATURE_NAME_PASCAL}}', variables['{{FEATURE_NAME_PASCAL}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  @override
  String getTemplate() => StateTemplates.riverpodProvider;

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
