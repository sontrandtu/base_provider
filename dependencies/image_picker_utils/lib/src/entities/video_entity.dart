import 'dart:io';

import 'package:image_picker_utils/src/entities/image_entity.dart';

class VideoEntity {
  String? path;
  String? title;
  String? author;
  int? width;
  int? height;

  /// [Android] API level 17
  int? orientation;

  /// bytes
  int? fileSize; // filesize
  /// microsecond
  double? duration;
  bool? isCancel;
  File? file;
  ImageEntity? thumbnail;

  VideoEntity({
    required this.path,
    this.title,
    this.author,
    this.width,
    this.height,
    this.orientation,
    this.fileSize,
    this.duration,
    this.isCancel,
    this.file,
  });

  void setThumbnail(ImageEntity file) {
    thumbnail = file;
  }

  VideoEntity.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    title = json['title'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    orientation = json['orientation'];
    fileSize = json['filesize'];
    duration = double.tryParse('${json['duration']}');
    isCancel = json['isCancel'];
    file = File(path!);
  }

  VideoEntity.fromMediaInfo(Map<String, dynamic> json) {
    path = json['path'];
    title = json['title'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    orientation = json['orientation'];
    fileSize = json['filesize'];
    duration = double.tryParse('${json['duration']}');
    isCancel = json['isCancel'];
    file = File(path!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['title'] = title;
    data['author'] = author;
    data['width'] = width;
    data['height'] = height;
    if (orientation != null) {
      data['orientation'] = orientation;
    }
    data['filesize'] = fileSize;
    data['duration'] = duration;
    if (isCancel != null) {
      data['isCancel'] = isCancel;
    }
    data['file'] = File(path!).toString();
    return data;
  }
}
