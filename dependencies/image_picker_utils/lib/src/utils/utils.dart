import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image_picker_utils/src/entities/image_entity.dart';

class Utils {
  static ImageEntity getFileInfo(File? file) {
    return ImageEntity(
        path: file?.path, size: file?.lengthSync(), file: file, name: file?.path.split('/').lastOrNull);
  }
}
