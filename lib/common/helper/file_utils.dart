import 'dart:io' as io;

enum FileOption { camera, gallery, document }

class FileUtils {

  // Check hạn kích cỡ file
  static Future<bool> checkSize(io.File file) async {
    final int fileSize = await file.length();

    return fileSize > (5 * 1024 * 1024);
  }
}
