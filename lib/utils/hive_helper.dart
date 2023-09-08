import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String settings = 'settings';
  static const String todos = 'todos';

  static Box settingsBox = Hive.box(settings);
  static Box todosBox = Hive.box(todos);

  static Future<void> initilize() async {
    await Hive.initFlutter();
    await Future.wait(
      [
        Hive.openBox(settings),
        Hive.openBox(todos),
      ],
    );
  }
}
