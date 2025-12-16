import '../models/generation_config.dart';
import '../utils/file_utils.dart';
import '../utils/string_utils.dart';
import '../templates/template_engine.dart';

abstract class BaseGenerator {
  final FileUtils fileUtils;

  BaseGenerator(this.fileUtils);

  /// Generates files based on the configuration
  Future<void> generate(GenerationConfig config);

  /// Gets the template string for this generator
  String getTemplate();

  /// Gets the output file path for this generator
  String getOutputPath(GenerationConfig config);

  /// Gets the template variables for rendering
  Map<String, String> getVariables(GenerationConfig config);

  /// Renders the template with variables and writes to file
  Future<void> renderAndWrite(
    GenerationConfig config,
    String template,
    String outputPath,
  ) async {
    final variables = getVariables(config);
    final content = TemplateEngine.render(template, variables);
    await fileUtils.writeFile(outputPath, content);
  }

  /// Helper method to get common variables used across generators
  Map<String, String> getCommonVariables(GenerationConfig config) {
    return {
      '{{FEATURE_NAME}}': config.featureName,
      '{{FEATURE_NAME_PASCAL}}': StringUtils.toPascalCase(config.featureName),
      '{{FEATURE_NAME_CAMEL}}': StringUtils.toCamelCase(config.featureName),
    };
  }
}
