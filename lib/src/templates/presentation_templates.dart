class PresentationTemplates {
  /// Template for screen widget
  static const String screen = '''
import 'package:flutter/material.dart';

class {{CLASS_NAME}} extends StatelessWidget {
  const {{CLASS_NAME}}({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{SCREEN_TITLE}}'),
      ),
      body: const Center(
        child: Text('{{CLASS_NAME}}'),
      ),
    );
  }
}
''';

  /// Template for widget
  static const String widget = '''
import 'package:flutter/material.dart';

class {{CLASS_NAME}} extends StatelessWidget {
  const {{CLASS_NAME}}({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: Implement widget
      child: const Placeholder(),
    );
  }
}
''';

  /// Template for stateful screen
  static const String statefulScreen = '''
import 'package:flutter/material.dart';

class {{CLASS_NAME}} extends StatefulWidget {
  const {{CLASS_NAME}}({super.key});

  @override
  State<{{CLASS_NAME}}> createState() => _{{CLASS_NAME}}State();
}

class _{{CLASS_NAME}}State extends State<{{CLASS_NAME}}> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{SCREEN_TITLE}}'),
      ),
      body: const Center(
        child: Text('{{CLASS_NAME}}'),
      ),
    );
  }
}
''';

  /// Template for stateful widget
  static const String statefulWidget = '''
import 'package:flutter/material.dart';

class {{CLASS_NAME}} extends StatefulWidget {
  const {{CLASS_NAME}}({super.key});

  @override
  State<{{CLASS_NAME}}> createState() => _{{CLASS_NAME}}State();
}

class _{{CLASS_NAME}}State extends State<{{CLASS_NAME}}> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: Implement widget
      child: const Placeholder(),
    );
  }
}
''';
}
