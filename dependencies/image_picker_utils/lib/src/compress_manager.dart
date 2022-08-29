import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class CompressManager {
  int _width = 720;
  int _height = 1280;
  int _quality = 70;
  late List<File> _files;
  late String? _targetLink;
  late Directory _dir;
  late Directory _appDir;

  CompressManager.builder() {
    _init();
  }

  void _init() async {
    _files = [];
    _dir = await getTemporaryDirectory();
  }

  CompressManager setMinWidth(int width) {
    _width = width;
    return this;
  }

  CompressManager setMinHeight(int height) {
    _height = height;
    return this;
  }

  CompressManager setQuality(int quality) {
    _quality = quality;
    return this;
  }

  CompressManager addFiles(List<File> files) {
    _files.addAll(files);
    return this;
  }

  CompressManager addFile(File file) {
    _files.add(file);
    return this;
  }

  Future<List<File?>> build() async {
    List<File?> response = [];

    await Future.forEach(_files, (File element) async {
      File? file = await FlutterImageCompress.compressAndGetFile(element.absolute.path, _dir.path + '/tmp_${element.path.split('/').last}',
          minWidth: _width, minHeight: _height, quality: _quality, rotate: 0);
      response.add(file);
    });

    return response;
  }
}
