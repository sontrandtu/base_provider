import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_utils/src/compress_manager.dart';

enum PickPurpose { avatar, normal }

enum PickSource { camera, gallery }

enum PickType { single, multiple }

class FileManager {
  late ImagePicker _imagePicker;
  late CompressManager _compressManager;
  late List<File> _files;
  PickSource _pickSource = PickSource.gallery;
  PickType _pickType = PickType.single;
  PickPurpose _pickPurpose = PickPurpose.normal;

  Future<List<File?>> Function()? _compress;

  FileManager() {
    _imagePicker = ImagePicker();
    _files = [];
  }

  FileManager setSource(PickSource source) {
    _pickSource = source;
    return this;
  }

  FileManager setPurpose(PickPurpose purpose) {
    _pickPurpose = purpose;
    return this;
  }

  FileManager setPickType(PickType type) {
    _pickType = type;
    return this;
  }

  FileManager hasCompress() {
    _compressManager = CompressManager();
    if (_pickPurpose == PickPurpose.avatar) _compressManager.setMinHeight(150).setMinHeight(150);
    _compress = _compressManager.compressAndGetFile;
    return this;
  }

  Future<File?> buildSingle() async {
    final XFile? _image = await _imagePicker.pickImage(
        source: _pickSource == PickSource.camera ? ImageSource.camera : ImageSource.gallery);

    if (_image == null) return null;

    _files.add(File(_image.path));

    if (_compress == null) return _files.first;

    _compressManager.addFiles(_files);

    List<File?>? files = await _compressManager.compressAndGetFile();

    return files?.first;
  }

  Future<List<File?>?> buildMultiple() async {
    final List<XFile>? _images = await _imagePicker.pickMultiImage(imageQuality: 100);
    if (_images == null) return null;

    _files.addAll(_images.map((e) => File(e.path)));

    if (_compress != null) _compressManager.addFiles(_files);

    List<File?>? files = await _compress?.call();

    return files;
  }
}
