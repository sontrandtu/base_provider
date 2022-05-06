import 'package:achitecture_weup/common/helper/file_utils.dart';
import 'package:flutter/material.dart' as material;
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:image_cropper/image_cropper.dart';

enum PickImageType { image, video }

class ImageUtils {
  final ImagePicker _picker = ImagePicker();


  static Future<dynamic> pickImage({bool hasCrop = false}) async {
    final ImagePicker _p = ImagePicker();
    final XFile? _image = await _p.pickImage(source: ImageSource.gallery);

    final rawFile = io.File(_image!.path);
    bool isSizeMax = await FileUtils.imgSize(rawFile);
    if (!isSizeMax) {
      if (!hasCrop) {
        return _image.path;
      } else {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: _image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: material.Colors.deepOrange,
                toolbarWidgetColor: material.Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        return croppedFile!.path;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> pick({PickImageType type = PickImageType.image}) async {
    if (type == PickImageType.image) {
      final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
      return _image!.path;
    } else {
      final XFile? _video = await _picker.pickVideo(source: ImageSource.gallery);
      return _video!.path;
    }
  }
}

class _ImageCrop {
  _ImageCrop._();


}