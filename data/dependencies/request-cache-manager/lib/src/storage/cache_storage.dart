import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';

class CacheStorage {
  CacheStorage._();

  static final CacheStorage _storage = CacheStorage._();

  factory CacheStorage() => _storage;

  final String _boxName = 'local.cache';

  late Box? _box;

  Future<void> ensureInitialized(String? path) async {
    Directory? dir = Directory.fromUri(Uri.parse('$path'));
    Hive.init(dir.path);
    await Hive.openBox(_boxName);
    _box = Hive.box(_boxName);
  }

  Future<void> put(String key, dynamic value) async {
    switch (value) {
      case String:
      case double:
      case bool:
      case int:
        await _box?.put(key, value);
        break;
      default:
        await _box?.put(key, jsonEncode(value));
        break;
    }
  }

  dynamic get<T>(String key, [dynamic defaultValue]) {
    if (!isExist(key)) return defaultValue;

    switch (T) {
      case String:
      case double:
      case bool:
      case int:
        return _box?.get(key, defaultValue: defaultValue);
      default:
        return jsonDecode(_box?.get(key));
    }
  }

  bool isExist(String key) {
    return _box?.containsKey(key) ?? false;
  }

  Future<void> delete(String key) async {
    await _box?.delete(key);
  }

  Future<void> clearData() async {
    _box?.clear();
  }
}

class StorageKey {
  static const String DATA = 'data';
  static const String HEADER = 'headers';
}
