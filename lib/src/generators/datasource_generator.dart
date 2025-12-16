import '../config/constants.dart';
import '../models/generation_config.dart';
import '../templates/data_templates.dart';
import '../utils/string_utils.dart';
import 'base_generator.dart';

class DatasourceGenerator extends BaseGenerator {
  DatasourceGenerator(super.fileUtils);

  @override
  Future<void> generate(GenerationConfig config) async {
    if (config.datasourceName == null) return;

    // Generate abstract datasource interface
    await _generateInterface(config);

    // Generate datasource implementation
    await _generateImplementation(config);
  }

  Future<void> _generateInterface(GenerationConfig config) async {
    final content = DataTemplates.datasourceInterface;
    final outputPath = _getInterfacePath(config);

    await renderAndWrite(config, content, outputPath);
  }

  Future<void> _generateImplementation(GenerationConfig config) async {
    final className = config.datasourceName!;
    final baseClassName = StringUtils.removeCommonSuffixes(className);
    final fileName = StringUtils.toSnakeCase(className);
    final implFileName = '${StringUtils.toSnakeCase(baseClassName)}${Constants.datasourceImplSuffix}';

    final variables = {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': '${className}Impl',
      '{{DATASOURCE_NAME}}': className,
      '{{DATASOURCE_FILE_NAME}}': fileName,
      '{{FILE_NAME}}': implFileName,
    };

    final content = DataTemplates.datasourceImplementation;
    final outputPath = '${config.dataPath}/${Constants.datasourcesFolder}/$implFileName.dart';

    final renderedContent = content.replaceAll('{{CLASS_NAME}}', variables['{{CLASS_NAME}}']!)
        .replaceAll('{{DATASOURCE_NAME}}', variables['{{DATASOURCE_NAME}}']!)
        .replaceAll('{{DATASOURCE_FILE_NAME}}', variables['{{DATASOURCE_FILE_NAME}}']!)
        .replaceAll('{{FEATURE_NAME_PASCAL}}', variables['{{FEATURE_NAME_PASCAL}}']!);

    await fileUtils.writeFile(outputPath, renderedContent);
  }

  String _getInterfacePath(GenerationConfig config) {
    final fileName = StringUtils.toSnakeCase(config.datasourceName!);
    return '${config.dataPath}/${Constants.datasourcesFolder}/$fileName.dart';
  }

  @override
  String getTemplate() => DataTemplates.datasourceInterface;

  @override
  String getOutputPath(GenerationConfig config) => _getInterfacePath(config);

  @override
  Map<String, String> getVariables(GenerationConfig config) {
    return {
      ...getCommonVariables(config),
      '{{CLASS_NAME}}': config.datasourceName!,
      '{{FILE_NAME}}': StringUtils.toSnakeCase(config.datasourceName!),
    };
  }
}
