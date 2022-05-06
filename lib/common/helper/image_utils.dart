import 'package:achitecture_weup/common/helper/file_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

enum PickImageType { image, video }

class ImageUtils {

  final ImagePicker _picker = ImagePicker();

  static Future<dynamic> pickImage({bool hasCrop = false}) async {
    final ImagePicker _p = ImagePicker();
    final XFile? _image = await _p.pickImage(source: ImageSource.gallery);

    final rawFile = io.File(_image!.path);
    bool isSizeMax = FileUtils.imgSize(rawFile);

    if (!isSizeMax) {
      if (!hasCrop) {}
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