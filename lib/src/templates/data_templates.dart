class DataTemplates {
  /// Template for abstract datasource interface
  static const String datasourceInterface = '''
abstract class {{CLASS_NAME}} {
  // TODO: Define your datasource methods here
  // Example:
  // Future<{{MODEL_NAME}}> get{{FEATURE_NAME_PASCAL}}Data();
  // Future<void> update{{FEATURE_NAME_PASCAL}}({{MODEL_NAME}} model);
  // Future<void> delete{{FEATURE_NAME_PASCAL}}(String id);
}
''';

  /// Template for datasource implementation
  static const String datasourceImplementation = '''
import '{{DATASOURCE_FILE_NAME}}.dart';

class {{CLASS_NAME}} implements {{DATASOURCE_NAME}} {
  {{CLASS_NAME}}();

  // TODO: Implement datasource methods
  // Example:
  // @override
  // Future<{{MODEL_NAME}}> get{{FEATURE_NAME_PASCAL}}Data() async {
  //   // Implementation here
  //   throw UnimplementedError();
  // }
}
''';

  /// Template for model class
  static const String model = '''
import '../../domain/entities/{{ENTITY_FILE_NAME}}.dart';

class {{CLASS_NAME}} extends {{ENTITY_NAME}} {
  const {{CLASS_NAME}}();

  factory {{CLASS_NAME}}.fromJson(Map<String, dynamic> json) {
    return const {{CLASS_NAME}}(
      // TODO: Parse JSON fields
      // Example:
      // id: json['id'] as String,
      // name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // TODO: Convert to JSON
      // Example:
      // 'id': id,
      // 'name': name,
    };
  }
}
''';

  /// Template for repository implementation
  static const String repositoryImplementation = '''
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/{{ENTITY_FILE_NAME}}.dart';
import '../../domain/repositories/{{REPOSITORY_FILE_NAME}}.dart';
import '../datasources/{{DATASOURCE_FILE_NAME}}.dart';

class {{CLASS_NAME}} implements {{REPOSITORY_NAME}} {
  final {{DATASOURCE_NAME}} datasource;

  {{CLASS_NAME}}({required this.datasource});

  // TODO: Implement repository methods
  // Example:
  // @override
  // Future<Either<Failure, {{ENTITY_NAME}}>> get{{FEATURE_NAME_PASCAL}}() async {
  //   try {
  //     final result = await datasource.get{{FEATURE_NAME_PASCAL}}Data();
  //     return Right(result);
  //   } catch (e) {
  //     return Left(ServerFailure());
  //   }
  // }
}
''';
}
