import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_utils/src/entities/image_entity.dart';
import 'package:image_picker_utils/src/interface/image_crop_base.dart';
import 'package:image_picker_utils/src/utils/utils.dart';

class CropManager extends ImageCropBase {
  late ImageCropper _cropper;
  int? _width;
  int? _height;
  File? _file;

  CropManager.builder() {
    _cropper = ImageCropper();
  }

  @override
  ImageCropBase setMaxWidth(int width) {
    _width = width;
    return this;
  }

  @override
  ImageCropBase setMaxHeight(int height) {
    _height = height;
    return this;
  }

  @override
  ImageCropBase addFile(File file) {
    _file = file;
    return this;
  }

  @override
  Future<ImageEntity?> build() async {
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
        AndroidUiSettings(toolbarTitle: 'Cropper', toolbarColor: Colors.red, toolbarWidgetColor: Colors.white),
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    if (croppedFile == null) return null;
    File file = File(croppedFile.path);

    return Utils.getFileInfo(file);
  }
}
