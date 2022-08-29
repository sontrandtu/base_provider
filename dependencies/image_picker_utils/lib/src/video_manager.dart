import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_utils/image_picker_utils.dart';
import 'package:image_picker_utils/src/compress_manager.dart';
import 'package:image_picker_utils/src/crop_manager.dart';
import 'package:image_picker_utils/src/video_compress_manager.dart';

class VideoManager {
  late ImagePicker _imagePicker;
  late List<File> _files;

  VideoCompressManager? _compressManager;


  PickSource _pickSource = PickSource.gallery;
  PickType _pickType = PickType.single;
  PickPurpose _pickPurpose = PickPurpose.normal;

  Future<VideoEntity?> Function()? _compress;

  VideoManager.builder() {
    _imagePicker = ImagePicker();
    _files = [];
  }

  VideoManager setSource(PickSource source) {
    _pickSource = source;
    return this;
  }

  VideoManager setPurpose(PickPurpose purpose) {
    _pickPurpose = purpose;
    return this;
  }

  VideoManager setPickType(PickType type) {
    _pickType = type;
    return this;
  }

  VideoManager hasCompress() {
    _compressManager = VideoCompressManager.builder();

    _compress = _compressManager?.build;

    return this;
  }

  VideoManager setQuality(int quality) {
    _compressManager?.setQuality(quality);
    return this;
  }



  Future<VideoEntity?> build() async {
    final XFile? _video = await _imagePicker.pickVideo(
        source: _pickSource == PickSource.camera ? ImageSource.camera : ImageSource.gallery);

    if (_video == null) return null;

    File? originalFile = File(_video.path);

    _files.add(originalFile);

    _calSize(_files, logName: 'Total Original Size');

    if (_compress == null) return VideoEntity(path: _video.path,file: originalFile);

    _compressManager?.setFile(_files.first);


    VideoEntity? _videoEntity = await _compress?.call();

    log('Total Compress Size: ${_videoEntity?.file?.lengthSync()} KB');

    return _videoEntity;
  }

  void _calSize(List<File?>? compressed, {String? logName}) async {
    int total = 0;

    compressed?.forEach((element) => total += ((element?.lengthSync() ?? 0) ~/ 1000));

    log('$logName: $total KB');
  }
}
