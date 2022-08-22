import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';

class CacheStorage {
  static const String boxName = 'local.cache';

  static Box box = Hive.box(boxName);
  static CollectionBox? collectionBox;

  static Future<void> ensureInitialized() async {
    Directory? dir = Directory.fromUri(Uri.parse('./storage/'));
    Hive.init(dir.path);
    await Hive.openBox(boxName);
  }

  static Future<void> put(String key, dynamic value, {bool isEncode = false}) async {
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

  static bool isExist(String key) {
    return box.containsKey(key);
  }

  static Future<void> delete(String key) async {
    if (!isExist(key)) return;
    await box.delete(key);
  }

  static Future<void> clearData() async {
    box.clear();
  }
}

class StorageKey {
  static const String DATA = 'data';
}
