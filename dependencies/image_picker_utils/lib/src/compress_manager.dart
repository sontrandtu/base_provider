import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class CompressManager {
  int _width = 720;
  int _height = 1280;
  int _quality = 1280;
  late List<File> _files;
  late String? _targetLink;
  late Directory _dir;
  late Directory _appDir;

  CompressManager() {
    _init();
  }

  void _init() async {
    _files = [];
    _dir = await getTemporaryDirectory();
    _appDir = await getApplicationDocumentsDirectory();
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

  Future<List<File?>> compressAndGetFile() async {
    List<File?> response = [];

    // await Future.forEach(_files, (File element) async {
    //
    //   File? file = await FlutterImageCompress.compressAndGetFile(element.absolute.path, _dir.path + '/tmp.jpg',
    //       minWidth: _width, minHeight: _height, quality: _quality, rotate: 0);
    //
    //   print('File compress property: ');
    //
    //   print(element.absolute.path);
    //   print(file?.path);
    //   print(file?.lengthSync());
    //   response.add(file);
    // });

    print(_dir.path + '/tmp.jpg');
    File? file = await FlutterImageCompress.compressAndGetFile(_files[0].absolute.path, _dir.path + '/tmp.jpg',
        minWidth: _width, minHeight: _height, quality: _quality, rotate: 0);

    print('File compress property: ');

    print(_files[0].absolute.path);
    print(file?.path);
    print(file?.lengthSync());
    response.add(file);
    return response;
  }
}
