import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_utils/image_picker_utils.dart';

class VideoManager {
  late ImagePicker _imagePicker;
  late List<File> _files;

  VideoCompressManager? _compressManager;

  PickSource _pickSource = PickSource.gallery;

  Future<VideoEntity?> Function()? _compress;

  VideoManager.builder() {
    _imagePicker = ImagePicker();
    _files = [];
  }

  VideoManager setSource(PickSource source) {
    _pickSource = source;
    return this;
  }

  VideoManager hasCompress({VideoCompressManager? compressManager}) {
    _compressManager = compressManager ?? VideoCompressManager.builder();

    _compress = _compressManager?.build;

    return this;
  }

  VideoManager setQuality(VQuality quality) {
    _compressManager?.setQuality(quality);
    return this;
  }

  Future<VideoEntity?> build() async {
    final XFile? _video = await _imagePicker.pickVideo(
        source: _pickSource == PickSource.camera ? ImageSource.camera : ImageSource.gallery);

    if (_video == null) return null;

    File? originalFile = File(_video.path);

    _calSize(originalFile, logName: 'Total Original Size');

    if (_compress == null) {
      return VideoEntity(
          path: _video.path,
          file: originalFile,
          fileSize: originalFile.lengthSync(),
          title: _video.path.split('/').last);
    }

    _compressManager?.setFile(_files.first);

    VideoEntity? _videoEntity = await _compress?.call();

    log('Total Compress Size: ${_videoEntity?.file?.lengthSync()} KB');

    return _videoEntity;
  }

  void _calSize(File? compressed, {String? logName}) async {
    int total = ((compressed?.lengthSync() ?? 0) ~/ 1024);

    log('$logName: $total KB');
  }
}
