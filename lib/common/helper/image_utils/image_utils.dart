import 'dart:io' as io;
import 'package:achitecture_weup/common/core/sys/permission_config.dart';
import 'package:achitecture_weup/common/helper/file_utils.dart';
import 'package:achitecture_weup/common/helper/image_utils/text_delegate.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'img_crop.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum PickImageType {
  image,
  video,
  audio,
  all,
}

class ImageUtils {
  ImageUtils._();
  static final _picker = ImagePicker();

  static Future<String>? selectImage({bool hasCrop = false, double? width, double? height, int? imageQuality, ImageSource source = ImageSource.gallery}) async {
    bool request = await PermissionConfig.instance.request(
        permission: Permission.camera,
        title: 'Thông báo',
        content: 'Bạn cần cấp quyền truy cập vào ${source == ImageSource.camera ? 'Camera' : 'Thư viện'}');
    if(!request) '';
    final XFile? _image = await _picker.pickImage(
      source: source,
      maxWidth: width,
      maxHeight: height,
      imageQuality: imageQuality,
    );
    if (_image == null) return '';

    final rawFile = io.File(_image.path);
    bool isMax = await FileUtils().checkSize(rawFile);

    if (!isMax) {
      if (!hasCrop) return _image.path;
      final _path = await ImgCrop.instance().cropFile(_image.path);
      return _path!;
    }
    return '';
  }

  static Future<String>? pick(
      {ImageSource source = ImageSource.camera, CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
    bool request = await PermissionConfig.instance.request(
        permission: Permission.camera,
        title: 'Thông báo',
        content: 'Bạn cần cấp quyền truy cập vào ${source == ImageSource.camera ? 'Camera' : 'Thư viện'}');
    if (!request) return '';
    final XFile? _file = await _picker.pickVideo(source: source, preferredCameraDevice: preferredCameraDevice);
    if (_file == null) return '';
    return _file.path;
  }

  static Future<dynamic>? multiply(
    BuildContext context, {
    int max = 9,
    int pageSize = 80,
    int gridCount = 4,
    ThumbnailSize? previewThumbnailSize,
    RequestType type = RequestType.common,
    List<AssetEntity>? values,
    bool isMap = true,
  }) async {
    final PermissionState state = await AssetPicker.permissionCheck();
    if(state != PermissionState.authorized) return;
    final _data = <Map<String, dynamic>>[];
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        textDelegate: const AssetPickerTextDelegateVN(),
        maxAssets: max,
        pageSize: pageSize,
        gridCount: gridCount,
        previewThumbnailSize: previewThumbnailSize,
        requestType: type,
        selectedAssets: values,
      ),
    );
    if (isMap) {
      if (result != null && result.isNotEmpty) {
        for (var element in result) {
          final res = await element.file;
          _data.add({
            'id': element.id,
            'title': element.title,
            'path': res!.path,
            'typeInt': element.typeInt,
            'width': element.width,
            'height': element.height,
          });
        }
      }
      if (!systemIsEmpty(_data)) {
        _data.last['isLast'] = 1;
      }
      return _data;
    }
    return result;
  }
}
