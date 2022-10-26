import 'dart:io';

import '../entities/image_entity.dart';

abstract class ImageCompressBase {


  void init();

  ImageCompressBase setMinWidth(int width);

  ImageCompressBase setMinHeight(int height);

  ImageCompressBase setQuality(int quality);

  ImageCompressBase addFiles(List<File> files);

  ImageCompressBase addFile(File file);

  Future<List<ImageEntity>?> build();
}
