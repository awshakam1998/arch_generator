import 'package:flutter_arch_generator/src/commands/generate_command.dart';

Future<void> main(List<String> arguments) async {
  final command = GenerateCommand();
  await command.run(arguments);
}
