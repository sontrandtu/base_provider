import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class CropManager {
  late ImageCropper _cropper;
  int? _width;
  int? _height;
  File? _file;

  CropManager.builder() {
    _cropper = ImageCropper();
  }

  CropManager setMaxWidth(int width) {
    _width = width;
    return this;
  }

  CropManager setMaxHeight(int height) {
    _height = height;
    return this;
  }

  CropManager addFile(File file) {
    _file = file;
    return this;
  }

  Future<File?> cropFile() async {
    CroppedFile? croppedFile = await _cropper.cropImage(
      sourcePath: _file?.path ?? '',
      aspectRatioPresets: _height == _width && _height != null && _width != null
          ? [CropAspectRatioPreset.square]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
      maxHeight: _height,
      maxWidth: _width,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile == null) return null;

    return File(croppedFile.path);
  }
}
