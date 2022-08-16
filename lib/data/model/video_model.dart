// import 'package:weup/domain/entity/stored_entity.dart';
// import 'package:weup/domain/entity/video_category_entity.dart';
//
// class VideoModel {
//   String? id;
//   String? categoryId;
//   String? title;
//   String? code;
//   String? type;
//   String? image;
//   String? video;
//   bool? isFeatured;
//   bool? isSaved;
//   String? content;
//
//   VideoModel(
//       {this.id, this.title, this.code, this.type, this.image, this.video, this.isFeatured, this.content});
//
//   VideoModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     code = json['code'];
//     type = json['type'];
//     image = json['image'];
//     video = json['video'];
//     isFeatured = json['is_featured'];
//     categoryId = json['category_id'];
//     content = json['content'];
//   }
//
//   VideoModel.fromEntity(VideoEntity? entity) {
//     id = entity?.id;
//     title = entity?.title;
//     image = entity?.image;
//     video = entity?.video;
//     content = entity?.content;
//     isSaved = entity?.isSaved;
//     categoryId = entity?.categoryId;
//   }
//
//   VideoModel.mapper(StoredEntity? entity) {
//     id = entity?.id;
//     title = entity?.name;
//     image = entity?.image;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     data['code'] = code;
//     data['type'] = type;
//     data['image'] = image;
//     data['category_id'] = categoryId;
//     data['video'] = video;
//     data['is_featured'] = isFeatured;
//     data['content'] = content;
//     return data;
//   }
// }
