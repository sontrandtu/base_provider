import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class CacheStorage {
  static const String boxName = 'local.cache';

  static Box box = Hive.box(boxName);
  static CollectionBox? collectionBox;

  static Future<void> ensureInitialized() async {
    // Directory? dir = Directory.fromUri(Uri.parse('./storage/'));
    Directory? dir = await getApplicationDocumentsDirectory();
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
    box.keys.forEach((element) {
      if (key.contains(element)) box.delete(element);
    });
  }

  static Future<void> show() async {
    print(box.keys);
    print(box.values);
  }

  static Future<void> clearData() async {
    box.clear();
  }
}

class StorageKey {
  static const String DATA = 'data';
}
