class StringUtils {
  /// Converts a string to snake_case
  /// Examples:
  /// - "AuthDatasource" -> "auth_datasource"
  /// - "LoginUsecase" -> "login_usecase"
  /// - "auth_datasource" -> "auth_datasource"
  static String toSnakeCase(String input) {
    if (input.isEmpty) return input;

    // Handle already snake_case strings
    if (!input.contains(RegExp(r'[A-Z]'))) {
      return input.toLowerCase();
    }

    // Insert underscore before uppercase letters and convert to lowercase
    return input
        .replaceAllMapped(
          RegExp(r'([A-Z])'),
          (match) => '_${match.group(0)!.toLowerCase()}',
        )
        .replaceFirst(RegExp(r'^_'), ''); // Remove leading underscore
  }

  /// Converts a string to PascalCase
  /// Examples:
  /// - "auth_datasource" -> "AuthDatasource"
  /// - "login_usecase" -> "LoginUsecase"
  /// - "AuthDatasource" -> "AuthDatasource"
  static String toPascalCase(String input) {
    if (input.isEmpty) return input;

    // If already PascalCase, return as is
    if (!input.contains('_') && input[0] == input[0].toUpperCase()) {
      return input;
    }

    // Split by underscore and capitalize each word
    return input
        .split('_')
        .map((word) => word.isEmpty
            ? ''
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join('');
  }

  /// Converts a string to camelCase
  /// Examples:
  /// - "auth_datasource" -> "authDatasource"
  /// - "AuthDatasource" -> "authDatasource"
  /// - "login_usecase" -> "loginUsecase"
  static String toCamelCase(String input) {
    if (input.isEmpty) return input;

    final pascalCase = toPascalCase(input);
    return pascalCase[0].toLowerCase() + pascalCase.substring(1);
  }

  /// Validates if a string is a valid Dart identifier
  static bool isValidDartIdentifier(String input) {
    if (input.isEmpty) return false;

    // Dart identifiers must start with a letter or underscore
    // and contain only letters, digits, and underscores
    final identifierRegex = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');

    if (!identifierRegex.hasMatch(input)) return false;

    // Check against Dart reserved keywords
    const reservedKeywords = [
      'abstract', 'as', 'assert', 'async', 'await',
      'break', 'case', 'catch', 'class', 'const',
      'continue', 'default', 'deferred', 'do', 'dynamic',
      'else', 'enum', 'export', 'extends', 'extension',
      'external', 'factory', 'false', 'final', 'finally',
      'for', 'function', 'get', 'hide', 'if',
      'implements', 'import', 'in', 'interface', 'is',
      'late', 'library', 'mixin', 'new', 'null',
      'on', 'operator', 'part', 'required', 'rethrow',
      'return', 'set', 'show', 'static', 'super',
      'switch', 'sync', 'this', 'throw', 'true',
      'try', 'typedef', 'var', 'void', 'while',
      'with', 'yield',
    ];

    return !reservedKeywords.contains(input.toLowerCase());
  }

  /// Removes common suffixes from class names
  /// Example: "AuthDatasource" -> "Auth" (removes "Datasource")
  static String removeCommonSuffixes(String input) {
    const suffixes = [
      'Datasource',
      'Repository',
      'Usecase',
      'UseCase',
      'Entity',
      'Model',
      'Params',
      'Screen',
      'Widget',
      'Bloc',
      'Provider',
      'Controller',
    ];

    for (final suffix in suffixes) {
      if (input.endsWith(suffix)) {
        return input.substring(0, input.length - suffix.length);
      }
    }

    return input;
  }
}
