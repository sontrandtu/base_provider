import 'dart:io';

import 'package:image_picker_utils/src/entities/image_entity.dart';

abstract class ImageCropBase {
  int? width;
  int? height;
  File? file;

  ImageCropBase setMaxWidth(int width);

  ImageCropBase setMaxHeight(int height);

  ImageCropBase addFile(File file);

  Future<ImageEntity?> build();
}
