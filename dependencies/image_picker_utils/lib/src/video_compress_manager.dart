import 'dart:io';

import 'package:video_compress/video_compress.dart';

import 'video_entity.dart';

class VideoCompressManager {
  // int _quality = 70;
  late File _file;

  VideoCompressManager.builder();

  VideoCompressManager setQuality(int quality) {
    // _quality = quality;
    return this;
  }

  VideoCompressManager setFile(File file) {
    _file = file;
    return this;
  }

  Future<VideoEntity?> build() async {
    MediaInfo? mediaInfo =
        await VideoCompress.compressVideo(_file.path, quality: VideoQuality.DefaultQuality,);
    if (mediaInfo == null) return null;

    return VideoEntity.fromJson(mediaInfo.toJson());
  }
}
