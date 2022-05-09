import 'dart:io' as io;

enum FileOption { camera, gallery, document }

class FileUtils {
  // Giới hạn kích cỡ file
  static size(io.File file) async {
    final int fileSize = await file.length();

    return fileSize > (5 * 1024 * 1024);
  }
}
