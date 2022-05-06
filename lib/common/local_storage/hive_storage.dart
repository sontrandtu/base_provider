import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveStorage {
  static const String boxName = 'local.data';
  static Box get box => Hive.box(boxName);

  static Future<void> install() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(boxName);
  }

  static Future<void> putValue(String key, dynamic value) async {

    switch (value) {
      case String:
      case double:
      case bool:
      case int:
        await box.put(key, value);
        break;
      default:
        await box.put(key, jsonEncode(value));
        break;
    }
  }

  static dynamic getValue(String key, dynamic defaultValue) {
    if (!box.containsKey(key)) return defaultValue;

    switch (defaultValue) {
      case String:
      case double:
      case bool:
      case int:
        return box.get(key, defaultValue: defaultValue);
      default:
        return jsonDecode(box.get(key));
    }
  }

  static delete(String key) {
    if (!box.containsKey(key)) {
      box.delete(key);
    }
  }

  static Future<void> clearData() async {
    final Box box = Hive.box(boxName);
    await box.deleteFromDisk();
  }

}

class HiveKey {
  static const String themeKey = 'light';
}
