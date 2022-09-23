import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image_picker_utils/image_picker_utils.dart';
import 'package:video_compress/video_compress.dart';

class VideoCompressManager extends VideoCompressBase {
  VideoCompressManager.builder();
  VideoQuality _quality = VideoQuality.DefaultQuality;
  bool _hasThumbnail = false;
  bool _shouldCompressThumb = false;
  late VideoEntity _entity;
  late File _file;


  @override
  VideoCompressBase setQuality(VQuality quality) {
    switch (quality) {
      case VQuality.low:
        _quality = VideoQuality.LowQuality;
        break;
      case VQuality.medium:
        _quality = VideoQuality.MediumQuality;
        break;
      case VQuality.original:
        _quality = VideoQuality.DefaultQuality;
        break;
      case VQuality.highest:
        _quality = VideoQuality.HighestQuality;
        break;
      case VQuality.r640x480:
        _quality = VideoQuality.Res640x480Quality;
        break;
      case VQuality.r960x540:
        _quality = VideoQuality.Res960x540Quality;
        break;
      case VQuality.r1280x720:
        _quality = VideoQuality.Res1280x720Quality;
        break;
      case VQuality.r1920x1080:
        _quality = VideoQuality.Res1920x1080Quality;
        break;
    }
    return this;
  }

  @override
  VideoCompressBase setFile(File file) {
    _file = file;
    return this;
  }

  @override
  VideoCompressBase hasGetThumbnail() {
    _hasThumbnail = true;
    return this;
  }

  @override
  VideoCompressBase shouldCompressThumbnail() {
    _shouldCompressThumb = true;
    return this;
  }

  @override
  Future<VideoEntity?> build() async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(_file.path, quality: _quality);
    if (mediaInfo == null) return null;

    _entity = VideoEntity.fromJson(mediaInfo.toJson());

    await getThumbnail();

    return _entity;
  }

  @override
  Future<void> getThumbnail() async {
    if (!_hasThumbnail) return;
    File _fileThumb = await VideoCompress.getFileThumbnail(_file.path, quality: 80);

    ImageEntity imageEntity = Utils.getFileInfo(_fileThumb);

    if (_shouldCompressThumb) {
      List<ImageEntity>? imageEntities = await CompressManager.builder().addFile(_fileThumb).build();

      if (imageEntities?.firstOrNull != null) imageEntity = imageEntities!.first;
    }

    _entity.setThumbnail(imageEntity);
  }
}
