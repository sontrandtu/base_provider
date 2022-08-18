import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

enum FileOption { camera, gallery, document }

class FileUtils {
  FileUtils._internal();

  static final FileUtils _instance = FileUtils._internal();

  factory FileUtils() => _instance;

  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Check hạn kích cỡ file
  Future<bool> checkSize(io.File file) async {
    final int fileSize = await file.length();
    return fileSize > (5 * 1024 * 1024);
  }

  Future<String> _getPath(String input) async {
    final _path = await getApplicationDocumentsDirectoryPath();
    return '$_path/$input';
  }
}
