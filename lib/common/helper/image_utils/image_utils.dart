import 'dart:io' as io;
import 'package:achitecture_weup/common/helper/file_utils.dart';
import 'package:achitecture_weup/common/helper/image_utils/text_delegate.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'img_crop.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum PickImageType {
  image,
  video,
  audio,
  all,
}

class ImageUtils {
  static final _picker = ImagePicker();

  static Future<dynamic> pickImage(
      {bool hasCrop = false,
      double? width,
      double? height,
      int? imageQuality}) async {
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: width,
      maxHeight: height,
      imageQuality: imageQuality,
    );

    final rawFile = io.File(_image!.path);
    bool isMax = await FileUtils().checkSize(rawFile);

    if (!isMax) {
      if (!hasCrop) return _image.path;
      final _path = await ImgCrop.instance().cropFile(_image.path);
      return _path;
    }
    return null;
  }

  // static Future<dynamic> pick(
  //     {PickImageType type = PickImageType.image}) async {
  //   if (type == PickImageType.image) {
  //     final XFile? _image =
  //         await _picker.pickImage(source: ImageSource.gallery);
  //     return _image!.path;
  //   } else {
  //     final XFile? _video =
  //         await _picker.pickVideo(source: ImageSource.gallery);
  //     return _video!.path;
  //   }
  // }

  static Future<dynamic>? multiply(
    BuildContext context, {
    int max = 9,
    int pageSize = 80,
    int gridCount = 4,
    ThumbnailSize? previewThumbnailSize,
    RequestType type = RequestType.common,
    List<AssetEntity>? selectedAssets,
    bool isMap = true,
  }) async {
    final _multi = <Map<String, dynamic>>[];
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        textDelegate: const AssetPickerTextDelegateVN(),
        maxAssets: max,
        pageSize: pageSize,
        gridCount: gridCount,
        previewThumbnailSize: previewThumbnailSize,
        requestType: type,
        selectedAssets: selectedAssets,
      ),
    );
    if (isMap) {
      if (result != null && result.isNotEmpty) {
        for (var element in result) {
          final res = await element.file;
          _multi.add({
            'id': element.id,
            'title': element.title,
            'path': res!.path,
            'typeInt': element.typeInt,
            'width': element.width,
            'height': element.height,
          });
        }
      }
      if (!empty(_multi)) {
        _multi.last['isLast'] = 1;
      }
      return _multi;
    }
    return result;
  }
}
