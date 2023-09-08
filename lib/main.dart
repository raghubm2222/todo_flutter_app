import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    runApp(
      DevicePreview(
        builder: (context) => const ProviderScope(
          child: TodoApp(),
        ),
      ),
    );
  } else {
    runApp(
      const ProviderScope(
        child: TodoApp(),
      ),
    );
  }
}
