import 'dart:io';

import 'package:image_picker_utils/src/entities/video_entity.dart';
import 'package:image_picker_utils/src/video/v_quality.dart';
import 'package:video_compress/video_compress.dart';

abstract class VideoCompressBase {

  VideoCompressBase setQuality(VQuality quality);

  VideoCompressBase setFile(File file);

  VideoCompressBase hasGetThumbnail();

  VideoCompressBase shouldCompressThumbnail();

  Future<VideoEntity?> build();

  Future<void> getThumbnail();
}
