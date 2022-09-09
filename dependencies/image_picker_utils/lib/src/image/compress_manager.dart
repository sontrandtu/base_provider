import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker_utils/src/entities/image_entity.dart';
import 'package:image_picker_utils/src/interface/image_compress_base.dart';
import 'package:image_picker_utils/src/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class CompressManager extends ImageCompressBase {
  CompressManager.builder() {
    init();
  }

  @override
  void init() async {
    files = [];
    dir = await getTemporaryDirectory();
  }

  @override
  ImageCompressBase setMinWidth(int width) {
    this.width = width;
    return this;
  }

  @override
  ImageCompressBase setMinHeight(int height) {
    this.height = height;
    return this;
  }

  @override
  ImageCompressBase setQuality(int quality) {
    this.quality = quality;
    return this;
  }

  @override
  ImageCompressBase addFiles(List<File> files) {
    this.files.addAll(files);
    return this;
  }

  @override
  ImageCompressBase addFile(File file) {
    files.add(file);
    return this;
  }

  @override
  Future<List<ImageEntity>?> build() async {
    List<File?> response = [];

    dir ??= await getTemporaryDirectory();

    await Future.forEach(files, (File element) async {
      String endPath =
          dir!.path + '/tmp_${DateTime.now().millisecondsSinceEpoch}_${element.path.split('/').last}';
      CompressFormat compressFormat = CompressFormat.jpeg;

      if (endPath.endsWith('.png')) compressFormat = CompressFormat.png;
      if (endPath.endsWith('.heic')) compressFormat = CompressFormat.heic;
      if (endPath.endsWith('.webp')) compressFormat = CompressFormat.webp;

      File? file = await FlutterImageCompress.compressAndGetFile(element.absolute.path, endPath,
          format: compressFormat, minWidth: width, minHeight: height, quality: quality, rotate: 0);
      response.add(file);
    });

    return response.map(Utils.getFileInfo).toList();
  }
}
