import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker_utils/src/entities/image_entity.dart';
import 'package:image_picker_utils/src/interface/image_compress_base.dart';
import 'package:image_picker_utils/src/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class CompressManager extends ImageCompressBase {

  int _width = 720;
  int _height = 1280;
  int _quality = 70;
  late List<File> _files;
  Directory? _dir;

  CompressManager.builder() {
    init();
  }

  @override
  void init() async {
    _files = [];
    _dir = await getTemporaryDirectory();
  }

  @override
  ImageCompressBase setMinWidth(int width) {
    _width = width;
    return this;
  }

  @override
  ImageCompressBase setMinHeight(int height) {
    _height = height;
    return this;
  }

  @override
  ImageCompressBase setQuality(int quality) {
    _quality = quality;
    return this;
  }

  @override
  ImageCompressBase addFiles(List<File> files) {
    _files.addAll(files);
    return this;
  }

  @override
  ImageCompressBase addFile(File file) {
    _files.add(file);
    return this;
  }

  @override
  Future<List<ImageEntity>?> build() async {
    List<File?> response = [];

    _dir ??= await getTemporaryDirectory();

    await Future.forEach(_files, (File element) async {
      String endPath =
          _dir!.path + '/tmp_${DateTime.now().millisecondsSinceEpoch}_${element.path.split('/').last}';
      CompressFormat compressFormat = CompressFormat.jpeg;

      if (endPath.endsWith('.png')) compressFormat = CompressFormat.png;
      if (endPath.endsWith('.heic')) compressFormat = CompressFormat.heic;
      if (endPath.endsWith('.webp')) compressFormat = CompressFormat.webp;

      File? file = await FlutterImageCompress.compressAndGetFile(element.absolute.path, endPath,
          format: compressFormat, minWidth: _width, minHeight: _height, quality: _quality, rotate: 0);
      response.add(file);
    });

    return response.map(Utils.getFileInfo).toList();
  }
}
