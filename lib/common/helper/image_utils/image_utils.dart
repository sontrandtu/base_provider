import 'dart:io' as io;
import 'dart:io';

import 'package:achitecture_weup/common/extension/app_extension.dart';
import 'package:achitecture_weup/common/helper/file_utils.dart';
import 'package:achitecture_weup/common/helper/image_utils/text_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../img_crop.dart';

enum PickImageType { image, video }

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();
  static final List<String> _multiImagePath = [];

  static Future<dynamic> pickImage(
      {bool hasCrop = false, double? width, double? height, int? imageQuality}) async {
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: width,
      maxHeight: height,
      imageQuality: imageQuality,
    );

    final rawFile = io.File(_image!.path);
    bool isMax = await FileUtils.checkSize(rawFile);

    if (!isMax) {
      if (!hasCrop) {
        return _image.path;
      } else {
        final _path = await ImgCrop.instance().cropFile(_image.path);
        return _path;
      }
    } else {
      return null;
    }
  }

  static Future<dynamic> pick({PickImageType type = PickImageType.image}) async {
    if (type == PickImageType.image) {
      final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
      return _image!.path;
    }
    final XFile? _video = await _picker.pickVideo(source: ImageSource.gallery);
    return _video!.path;
  }

  static Future<List<String>> pickMultiImage() async {
    List<XFile>? _images = await _picker.pickMultiImage();
    if (_images == null) return [];
    if (_images.isEmpty) return [];
    for (var element in _images) {
      String _path = File(element.path).name;
      _multiImagePath.add(_path);
    }

    return _multiImagePath;
  }

  static multiply(BuildContext context) async {
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        // filterOptions: FilterOptionGroup(),
        textDelegate: AssetPickerTextDelegateVN(),
      ),
    );
  }
}
