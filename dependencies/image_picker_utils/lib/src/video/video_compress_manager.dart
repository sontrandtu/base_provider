import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image_picker_utils/image_picker_utils.dart';
import 'package:video_compress/video_compress.dart';

class VideoCompressManager extends VideoCompressBase {
  VideoCompressManager.builder();

  @override
  VideoCompressBase setQuality(VQuality quality) {
    switch (quality) {
      case VQuality.low:
        this.quality = VideoQuality.LowQuality;
        break;
      case VQuality.medium:
        this.quality = VideoQuality.MediumQuality;
        break;
      case VQuality.original:
        this.quality = VideoQuality.DefaultQuality;
        break;
      case VQuality.highest:
        this.quality = VideoQuality.HighestQuality;
        break;
      case VQuality.r640x480:
        this.quality = VideoQuality.Res640x480Quality;
        break;
      case VQuality.r960x540:
        this.quality = VideoQuality.Res960x540Quality;
        break;
      case VQuality.r1280x720:
        this.quality = VideoQuality.Res1280x720Quality;
        break;
      case VQuality.r1920x1080:
        this.quality = VideoQuality.Res1920x1080Quality;
        break;
    }
    return this;
  }

  @override
  VideoCompressBase setFile(File file) {
    this.file = file;
    return this;
  }

  @override
  VideoCompressBase hasGetThumbnail() {
    hasThumbnail = true;
    return this;
  }

  @override
  VideoCompressBase shouldCompressThumbnail() {
    shouldCompressThumb = true;
    return this;
  }

  @override
  Future<VideoEntity?> build() async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(file.path, quality: quality);
    if (mediaInfo == null) return null;

    entity = VideoEntity.fromJson(mediaInfo.toJson());

    await getThumbnail();

    return entity;
  }

  @override
  Future<void> getThumbnail() async {
    if (!hasThumbnail) return;
    File _file = await VideoCompress.getFileThumbnail(file.path, quality: 80);

    ImageEntity imageEntity = Utils.getFileInfo(file);

    if (shouldCompressThumb) {
      List<ImageEntity>? imageEntities = await CompressManager.builder().addFile(_file).build();

      if (imageEntities?.firstOrNull != null) imageEntity = imageEntities!.first;
    }

    entity.setThumbnail(imageEntity);
  }
}
