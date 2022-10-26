import 'dart:io';

class PathUtils {
  PathUtils._internal();

  static final PathUtils _instance = PathUtils._internal();

  factory PathUtils() => _instance;

  Future<Directory> getApplicationDocumentsDirectory() => getApplicationDocumentsDirectory();

  Future<Directory> getTemporaryDirectory() => getTemporaryDirectory();

  Future<Directory> getApplicationSupportDirectory() => getApplicationSupportDirectory();
}
