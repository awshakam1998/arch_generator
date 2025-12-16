import 'dart:io';
import 'package:path/path.dart' as path;
import 'logger.dart';

class FileUtils {
  final Logger logger;

  FileUtils(this.logger);

  /// Creates a directory recursively
  /// Returns true if successful, false otherwise
  Future<bool> createDirectory(String directoryPath) async {
    try {
      final dir = Directory(directoryPath);

      if (await dir.exists()) {
        logger.detail('Directory already exists: $directoryPath');
        return true;
      }

      await dir.create(recursive: true);
      logger.detail('Created directory: $directoryPath');
      return true;
    } catch (e) {
      logger.error('Failed to create directory $directoryPath: $e');
      return false;
    }
  }

  /// Writes content to a file
  /// Returns true if successful, false otherwise
  /// If the file already exists, it will be overwritten
  Future<bool> writeFile(String filePath, String content) async {
    try {
      final file = File(filePath);

      // Create parent directory if it doesn't exist
      final parentDir = file.parent;
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }

      await file.writeAsString(content);
      logger.success('Created: ${_relativePath(filePath)}');
      return true;
    } catch (e) {
      logger.error('Failed to write file $filePath: $e');
      return false;
    }
  }

  /// Checks if a file exists
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      logger.error('Failed to check file existence $filePath: $e');
      return false;
    }
  }

  /// Checks if a directory exists
  Future<bool> directoryExists(String directoryPath) async {
    try {
      final dir = Directory(directoryPath);
      return await dir.exists();
    } catch (e) {
      logger.error('Failed to check directory existence $directoryPath: $e');
      return false;
    }
  }

  /// Formats Dart code in a file using dart format
  Future<void> formatFile(String filePath) async {
    try {
      final result = await Process.run('dart', ['format', filePath]);
      if (result.exitCode != 0) {
        logger.warn('Failed to format $filePath: ${result.stderr}');
      }
    } catch (e) {
      logger.warn('Could not format file: $e');
    }
  }

  /// Formats all Dart files in a directory
  Future<void> formatDirectory(String directoryPath) async {
    try {
      final result = await Process.run('dart', ['format', directoryPath]);
      if (result.exitCode == 0) {
        logger.detail('Formatted all files in $directoryPath');
      } else {
        logger.warn('Failed to format directory: ${result.stderr}');
      }
    } catch (e) {
      logger.warn('Could not format directory: $e');
    }
  }

  /// Gets a relative path from the current directory
  String _relativePath(String absolutePath) {
    final current = Directory.current.path;
    if (absolutePath.startsWith(current)) {
      return path.relative(absolutePath, from: current);
    }
    return absolutePath;
  }

  /// Joins path segments
  String joinPath(List<String> segments) {
    return path.joinAll(segments);
  }

  /// Gets the absolute path
  String absolutePath(String relativePath) {
    return path.absolute(relativePath);
  }
}
