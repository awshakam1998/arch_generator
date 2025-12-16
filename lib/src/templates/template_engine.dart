class TemplateEngine {
  /// Renders a template by replacing placeholders with actual values
  ///
  /// Placeholders are in the format {{VARIABLE_NAME}}
  /// Example:
  ///   template: "class {{CLASS_NAME}} {}"
  ///   variables: {"{{CLASS_NAME}}": "MyClass"}
  ///   result: "class MyClass {}"
  static String render(String template, Map<String, String> variables) {
    String result = template;

    // Replace all placeholders with their corresponding values
    variables.forEach((placeholder, value) {
      result = result.replaceAll(placeholder, value);
    });

    return result;
  }

  /// Renders multiple templates with the same variables
  static Map<String, String> renderMultiple(
    Map<String, String> templates,
    Map<String, String> variables,
  ) {
    final result = <String, String>{};

    templates.forEach((key, template) {
      result[key] = render(template, variables);
    });

    return result;
  }

  /// Checks if a template has any unresolved placeholders
  static bool hasUnresolvedPlaceholders(String template) {
    return template.contains(RegExp(r'\{\{[A-Z_]+\}\}'));
  }

  /// Gets all placeholders from a template
  static List<String> getPlaceholders(String template) {
    final regex = RegExp(r'\{\{([A-Z_]+)\}\}');
    final matches = regex.allMatches(template);
    return matches.map((match) => match.group(0)!).toList();
  }
}
