import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_utils/src/compress_manager.dart';
import 'package:image_picker_utils/src/crop_manager.dart';

enum PickPurpose { avatar, normal }

enum PickSource { camera, gallery }

enum PickType { single, multiple }

class ImageManager {
  late ImagePicker _imagePicker;
  late List<File> _files;

  CompressManager? _compressManager;
  CropManager? _cropManager;

  PickSource _pickSource = PickSource.gallery;
  PickType _pickType = PickType.single;
  PickPurpose _pickPurpose = PickPurpose.normal;

  Future<List<File?>> Function()? _compress;

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
    _pickType = type;
    return this;
  }

  ImageManager hasCompress() {
    _compressManager = CompressManager.builder();

    if (_pickPurpose == PickPurpose.avatar) _compressManager?.setMinHeight(150).setMinHeight(150);

    _compress = _compressManager?.build;

    return this;
  }

  ImageManager setMinWidth(int width) {
    _compressManager?.setMinWidth(width);
    return this;
  }

  ImageManager setMinHeight(int height) {
    _compressManager?.setMinHeight(height);
    return this;
  }

  ImageManager setQuality(int quality) {
    _compressManager?.setQuality(quality);
    return this;
  }

  ImageManager hasCrop() {
    _cropManager = CropManager.builder();

    if (_pickPurpose == PickPurpose.avatar) _cropManager?.setMaxWidth(150).setMaxHeight(150);

    return this;
  }

  Future<File?> buildSingle() async {
    final XFile? _image = await _imagePicker.pickImage(
        source: _pickSource == PickSource.camera ? ImageSource.camera : ImageSource.gallery);

    if (_image == null) return null;

    File? originalFile = File(_image.path);

    if (_cropManager != null) {
      _cropManager?.addFile(originalFile);

      File? cropped = await _cropManager?.cropFile();

      if (cropped == null) return null;

      originalFile = cropped;
    }

    _files.add(originalFile);

    _calSize(_files, logName: 'Total Original Size');

    if (_compress == null) return _files.first;

    _compressManager?.addFiles(_files);

    List<File?>? files = await _compress?.call();

    _calSize(files, logName: 'Total Compress Size');

    return files?.first;
  }

  Future<List<File?>?> buildMultiple() async {
    final List<XFile>? _images = await _imagePicker.pickMultiImage();

    if (_images == null) return null;

    _files.addAll(_images.map((e) => File(e.path)));

    _calSize(_files, logName: 'Total Original Size');

    if (_compress != null) _compressManager?.addFiles(_files);

    List<File?>? files = await _compress?.call();

    _calSize(files, logName: 'Total Compress Size');

    return files;
  }

  void _calSize(List<File?>? compressed, {String? logName}) async {
    int total = 0;

    compressed?.forEach((element) => total += ((element?.lengthSync() ?? 0) ~/ 1000));

    log('$logName: $total KB');
  }
}
