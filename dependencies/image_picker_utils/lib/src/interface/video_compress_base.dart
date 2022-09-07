import 'dart:io';

import 'package:image_picker_utils/src/entities/video_entity.dart';
import 'package:image_picker_utils/src/video/v_quality.dart';
import 'package:video_compress/video_compress.dart';

abstract class VideoCompressBase {
  VideoQuality quality = VideoQuality.DefaultQuality;
  bool hasThumbnail = false;
  bool shouldCompressThumb = false;
  late VideoEntity entity;
  late File file;

  VideoCompressBase setQuality(VQuality quality);

  VideoCompressBase setFile(File file);

  VideoCompressBase hasGetThumbnail();

  VideoCompressBase shouldCompressThumbnail();

  Future<VideoEntity?> build();

  Future<void> getThumbnail();
}
