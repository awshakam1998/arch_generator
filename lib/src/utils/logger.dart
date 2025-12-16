import 'dart:io';

class Logger {
  // ANSI color codes
  static const String _reset = '\x1B[0m';
  static const String _green = '\x1B[32m';
  static const String _red = '\x1B[31m';
  static const String _yellow = '\x1B[33m';
  static const String _cyan = '\x1B[36m';
  static const String _gray = '\x1B[90m';

  /// Logs a success message (green)
  void success(String message) {
    print('$_green✓ $message$_reset');
  }

  /// Logs an error message (red)
  void error(String message) {
    stderr.writeln('$_red✗ $message$_reset');
  }

  /// Logs a warning message (yellow)
  void warn(String message) {
    print('$_yellow⚠ $message$_reset');
  }

  /// Logs an info message (cyan)
  void info(String message) {
    print('$_cyan$message$_reset');
  }

  /// Logs a detail message (gray)
  void detail(String message) {
    print('$_gray$message$_reset');
  }

  /// Logs a message without any formatting
  void write(String message) {
    print(message);
  }

  /// Logs a header message
  void header(String message) {
    print('');
    print('$_cyan${'═' * 60}$_reset');
    print('$_cyan $message$_reset');
    print('$_cyan${'═' * 60}$_reset');
    print('');
  }

  /// Logs a section divider
  void divider() {
    print('$_gray${'─' * 60}$_reset');
  }
}
