class StateTemplates {
  // ==================== BLOC Templates ====================

  /// Template for Bloc file
  static const String bloc = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '{{FEATURE_NAME}}_event.dart';
part '{{FEATURE_NAME}}_state.dart';

class {{CLASS_NAME}}Bloc extends Bloc<{{CLASS_NAME}}Event, {{CLASS_NAME}}State> {
  {{CLASS_NAME}}Bloc() : super({{CLASS_NAME}}Initial()) {
    on<{{CLASS_NAME}}Event>(_on{{CLASS_NAME}}Event);
  }

  Future<void> _on{{CLASS_NAME}}Event(
    {{CLASS_NAME}}Event event,
    Emitter<{{CLASS_NAME}}State> emit,
  ) async {
    // TODO: Add event handlers
    // Example:
    // emit({{CLASS_NAME}}Loading());
    // try {
    //   // Call usecase
    //   emit({{CLASS_NAME}}Loaded());
    // } catch (e) {
    //   emit({{CLASS_NAME}}Error(e.toString()));
    // }
  }
}
''';

  /// Template for Bloc Event file
  static const String blocEvent = '''
part of '{{FEATURE_NAME}}_bloc.dart';

abstract class {{CLASS_NAME}}Event extends Equatable {
  const {{CLASS_NAME}}Event();

  @override
  List<Object> get props => [];
}

// TODO: Add specific events
// Example:
// class Load{{CLASS_NAME}} extends {{CLASS_NAME}}Event {
//   const Load{{CLASS_NAME}}();
// }
''';

  /// Template for Bloc State file
  static const String blocState = '''
part of '{{FEATURE_NAME}}_bloc.dart';

abstract class {{CLASS_NAME}}State extends Equatable {
  const {{CLASS_NAME}}State();

  @override
  List<Object> get props => [];
}

class {{CLASS_NAME}}Initial extends {{CLASS_NAME}}State {}

class {{CLASS_NAME}}Loading extends {{CLASS_NAME}}State {}

class {{CLASS_NAME}}Loaded extends {{CLASS_NAME}}State {
  // TODO: Add loaded state data
  const {{CLASS_NAME}}Loaded();
}

class {{CLASS_NAME}}Error extends {{CLASS_NAME}}State {
  final String message;

  const {{CLASS_NAME}}Error(this.message);

  @override
  List<Object> get props => [message];
}
''';

  // ==================== Provider Templates ====================

  /// Template for Provider (ChangeNotifier)
  static const String provider = '''
import 'package:flutter/foundation.dart';

class {{CLASS_NAME}}Provider extends ChangeNotifier {
  // TODO: Add state properties
  // Example:
  // bool _isLoading = false;
  // bool get isLoading => _isLoading;

  {{CLASS_NAME}}Provider();

  // TODO: Add methods
  // Example:
  // Future<void> load{{FEATURE_NAME_PASCAL}}() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     // Call usecase
  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     rethrow;
  //   }
  // }
}
''';

  // ==================== GetX Templates ====================

  /// Template for GetX Controller
  static const String getxController = '''
import 'package:get/get.dart';

class {{CLASS_NAME}}Controller extends GetxController {
  // TODO: Add reactive state properties
  // Example:
  // final isLoading = false.obs;
  // final errorMessage = ''.obs;

  {{CLASS_NAME}}Controller();

  @override
  void onInit() {
    super.onInit();
    // TODO: Initialize controller
  }

  @override
  void onReady() {
    super.onReady();
    // TODO: Called when controller is ready
  }

  @override
  void onClose() {
    // TODO: Clean up resources
    super.onClose();
  }

  // TODO: Add methods
  // Example:
  // Future<void> load{{FEATURE_NAME_PASCAL}}() async {
  //   isLoading.value = true;
  //   try {
  //     // Call usecase
  //     isLoading.value = false;
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //     isLoading.value = false;
  //   }
  // }
}
''';

  /// Template for GetX Binding
  static const String getxBinding = '''
import 'package:get/get.dart';
import '{{CONTROLLER_FILE_NAME}}_controller.dart';

class {{CLASS_NAME}}Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<{{CONTROLLER_NAME}}>(
      () => {{CONTROLLER_NAME}}(),
    );
  }
}
''';

  // ==================== Riverpod Templates ====================

  /// Template for Riverpod Provider
  static const String riverpodProvider = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Define your providers
// Example:

// StateNotifierProvider
// final {{FEATURE_NAME_CAMEL}}Provider = StateNotifierProvider<{{CLASS_NAME}}Notifier, {{CLASS_NAME}}State>(
//   (ref) => {{CLASS_NAME}}Notifier(),
// );

// FutureProvider
// final {{FEATURE_NAME_CAMEL}}Provider = FutureProvider<{{ENTITY_NAME}}>((ref) async {
//   // Call usecase
//   throw UnimplementedError();
// });

// StreamProvider
// final {{FEATURE_NAME_CAMEL}}Provider = StreamProvider<{{ENTITY_NAME}}>((ref) {
//   // Return stream
//   throw UnimplementedError();
// });
''';

  /// Template for Riverpod StateNotifier
  static const String riverpodNotifier = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

class {{CLASS_NAME}}State {
  final bool isLoading;
  final String? error;
  // TODO: Add state properties

  const {{CLASS_NAME}}State({
    this.isLoading = false,
    this.error,
  });

  {{CLASS_NAME}}State copyWith({
    bool? isLoading,
    String? error,
  }) {
    return {{CLASS_NAME}}State(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class {{CLASS_NAME}}Notifier extends StateNotifier<{{CLASS_NAME}}State> {
  {{CLASS_NAME}}Notifier() : super(const {{CLASS_NAME}}State());

  // TODO: Add methods
  // Example:
  // Future<void> load{{FEATURE_NAME_PASCAL}}() async {
  //   state = state.copyWith(isLoading: true, error: null);
  //   try {
  //     // Call usecase
  //     state = state.copyWith(isLoading: false);
  //   } catch (e) {
  //     state = state.copyWith(isLoading: false, error: e.toString());
  //   }
  // }
}
''';
}
