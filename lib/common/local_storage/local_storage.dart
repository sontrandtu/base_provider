import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String boxName = 'local.data';

  static Box box = Hive.box(boxName);

  static Future<void> ensureInitialized() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Future<void> put(String key, dynamic value) async {
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

  static dynamic get<T>(String key, [dynamic defaultValue]) {
    if (!isExist(key)) return defaultValue;

    switch (T) {
      case String:
      case double:
      case bool:
      case int:
        return box.get(key, defaultValue: defaultValue);
      default:
        return jsonDecode(box.get(key));
    }
  }

  static bool isExist(String key) => box.containsKey(key);

  static Future<void> delete(String key) async {
    if (!isExist(key)) return;
    await box.delete(key);
  }

  static Future<void> clearData() async {
    final Box box = Hive.box(boxName);
    await box.deleteFromDisk();
  }
}

class StorageKey {
  static const String THEME = 'THEME';
  static const String LANGUAGE = 'LANGUAGE';
}
