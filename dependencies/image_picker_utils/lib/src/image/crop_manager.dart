import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_utils/src/entities/image_entity.dart';
import 'package:image_picker_utils/src/interface/image_crop_base.dart';
import 'package:image_picker_utils/src/utils/utils.dart';

class CropManager extends ImageCropBase {
  late ImageCropper _cropper;

  CropManager.builder() {
    _cropper = ImageCropper();
  }

  @override
  ImageCropBase setMaxWidth(int width) {
    this.width = width;
    return this;
  }

  @override
  ImageCropBase setMaxHeight(int height) {
    this.height = height;
    return this;
  }

  @override
  ImageCropBase addFile(File file) {
    this.file = file;
    return this;
  }

  @override
  Future<ImageEntity?> build() async {
    CroppedFile? croppedFile = await _cropper.cropImage(
      sourcePath: this.file?.path ?? '',
      aspectRatioPresets: height == width && height != null && width != null
          ? [CropAspectRatioPreset.square]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
      maxHeight: height,
      maxWidth: width,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper', toolbarColor: Colors.red, toolbarWidgetColor: Colors.white),
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    if (croppedFile == null) return null;
    File file = File(croppedFile.path);

    return Utils.getFileInfo(file);
  }
}
