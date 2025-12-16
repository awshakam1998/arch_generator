class DomainTemplates {
  /// Template for entity class
  static const String entity = '''
import 'package:equatable/equatable.dart';

class {{CLASS_NAME}} extends Equatable {
  // TODO: Add entity properties
  // Example:
  // final String id;
  // final String name;

  const {{CLASS_NAME}}();

  @override
  List<Object?> get props => [
    // TODO: Add properties to props list for equality comparison
    // Example:
    // id,
    // name,
  ];
}
''';

  /// Template for repository interface
  static const String repositoryInterface = '''
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entities/{{ENTITY_FILE_NAME}}.dart';

abstract class {{CLASS_NAME}} {
  // TODO: Define repository methods
  // Example:
  // Future<Either<Failure, {{ENTITY_NAME}}>> get{{FEATURE_NAME_PASCAL}}();
  // Future<Either<Failure, void>> update{{FEATURE_NAME_PASCAL}}({{ENTITY_NAME}} entity);
  // Future<Either<Failure, void>> delete{{FEATURE_NAME_PASCAL}}(String id);
}
''';

  /// Template for usecase class
  static const String usecase = '''
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/{{ENTITY_FILE_NAME}}.dart';
import '../params/{{PARAM_FILE_NAME}}.dart';
import '../repositories/{{REPOSITORY_FILE_NAME}}.dart';

class {{CLASS_NAME}} implements UseCase<{{ENTITY_NAME}}, {{PARAM_NAME}}> {
  final {{REPOSITORY_NAME}} repository;

  {{CLASS_NAME}}(this.repository);

  @override
  Future<Either<Failure, {{ENTITY_NAME}}>> call({{PARAM_NAME}} params) async {
    // TODO: Implement usecase logic
    // Example:
    // return await repository.get{{FEATURE_NAME_PASCAL}}();
    throw UnimplementedError();
  }
}
''';

  /// Template for params class
  static const String params = '''
import 'package:equatable/equatable.dart';

class {{CLASS_NAME}} extends Equatable {
  // TODO: Add parameter properties
  // Example:
  // final String id;
  // final String name;

  const {{CLASS_NAME}}();

  @override
  List<Object?> get props => [
    // TODO: Add properties to props list
    // Example:
    // id,
    // name,
  ];
}
''';

  /// Template for base UseCase class (helper for core)
  static const String baseUseCase = '''
import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
''';

  /// Template for Failure class (helper for core)
  static const String failures = '''
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}
''';
}
