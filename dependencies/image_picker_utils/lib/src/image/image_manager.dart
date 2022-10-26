import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_utils/src/entities/image_entity.dart';
import 'package:image_picker_utils/src/image/compress_manager.dart';
import 'package:image_picker_utils/src/image/crop_manager.dart';
import 'package:image_picker_utils/src/interface/image_compress_base.dart';
import 'package:image_picker_utils/src/utils/utils.dart';

import '../interface/image_crop_base.dart';

enum PickPurpose { avatar, normal }

enum PickSource { camera, gallery }

enum PickType { single, multiple }

class ImageManager {
  late ImagePicker _imagePicker;
  late List<File> _files;

  ImageCompressBase? _compressManager;
  ImageCropBase? _cropManager;

  PickSource _pickSource = PickSource.gallery;

  // PickType _pickType = PickType.single;
  PickPurpose _pickPurpose = PickPurpose.normal;

  Future<List<ImageEntity>?> Function()? _compress;

  ImageManager.builder() {
    _imagePicker = ImagePicker();
    _files = [];
  }

  ImageManager setSource(PickSource source) {
    _pickSource = source;
    return this;
  }

  ImageManager setPurpose(PickPurpose purpose) {
    _pickPurpose = purpose;
    return this;
  }

  ImageManager setPickType(PickType type) {
    // _pickType = type;
    return this;
  }

  ImageManager hasCompress({ImageCompressBase? compressTool}) {
    _compressManager = compressTool ?? CompressManager.builder();

    if (_pickPurpose == PickPurpose.avatar) _compressManager?.setMinHeight(150).setMinHeight(150);

    _compress = _compressManager?.build;

    return this;
  }

  ImageManager setMinWidth(int width) {
    _compressManager?.setMinWidth(width);
    _cropManager?.setMaxWidth(width);
    return this;
  }

  ImageManager setMinHeight(int height) {
    _compressManager?.setMinHeight(height);
    _cropManager?.setMaxHeight(height);
    return this;
  }

  ImageManager setQuality(int quality) {
    _compressManager?.setQuality(quality);
    return this;
  }

  ImageManager hasCrop({ImageCropBase? cropTool}) {
    _cropManager = cropTool ?? CropManager.builder();

    if (_pickPurpose == PickPurpose.avatar) _cropManager?.setMaxWidth(150).setMaxHeight(150);

    return this;
  }

  Future<ImageEntity?> single() async {
    final XFile? _image = await _imagePicker.pickImage(
        source: _pickSource == PickSource.camera ? ImageSource.camera : ImageSource.gallery);

    if (_image == null) return null;

    File originalFile = File(_image.path);

    if (_cropManager != null) {
      _cropManager?.addFile(originalFile);

      ImageEntity? cropped = await _cropManager?.build();

      if (cropped?.file == null) return null;

      originalFile = cropped!.file!;
    }

    _files.add(originalFile);

    _calSize(_files, logName: 'Total Original Size');

    if (_compressManager == null) return Utils.getFileInfo(_files.first);

    _compressManager?.addFiles(_files);

    List<ImageEntity?>? files = await _compress?.call();

    _calSize(files?.map((e) => e?.file).toList(), logName: 'Total Compress Size');

    return files?.first;
  }

  Future<List<ImageEntity>?> multiple() async {
    final List<XFile>? _images = await _imagePicker.pickMultiImage();

    if (_images == null) return null;

    _files.addAll(_images.map((e) => File(e.path)));

    _calSize(_files, logName: 'Total Original Size');

    if (_compress == null) return _files.map(Utils.getFileInfo).toList();

    _compressManager?.addFiles(_files);

    List<ImageEntity>? files = await _compress?.call();

    _calSize(files?.map((e) => e.file).toList(), logName: 'Total Compress Size');

    return files;
  }

  void _calSize(List<File?>? compressed, {String? logName}) async {
    int total = 0;

    compressed?.forEach((element) => total += ((element?.lengthSync() ?? 0) ~/ 1024));

    log('$logName: $total KB');
  }
}
