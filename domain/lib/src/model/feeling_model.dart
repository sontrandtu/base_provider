class FeelingModel {
  String? id;
  String? contactId;
  String? courseId;
  String? courseLessonId;
  String? contactName;
  String? contactAvatar;
  String? content;
  List<String>? images;
  String? video;
  int? timeVideo;
  String? updatedAt;
  String? createdAt;

  FeelingModel(
      {this.id,
        this.contactId,
        this.courseId,
        this.courseLessonId,
        this.contactName,
        this.contactAvatar,
        this.content,
        this.images,
        this.video,
        this.timeVideo,
        this.updatedAt,
        this.createdAt});

  FeelingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactId = json['contact_id'];
    courseId = json['course_id'];
    courseLessonId = json['course_lesson_id'];
    contactName = json['contact_name'];
    contactAvatar = json['contact_avatar'];
    content = json['content'];
    images = json['images']?.cast<String>();
    video = json['video'];
    timeVideo = json['time_video'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contact_id'] = contactId;
    data['course_id'] = courseId;
    data['course_lesson_id'] = courseLessonId;
    data['contact_name'] = contactName;
    data['contact_avatar'] = contactAvatar;
    data['content'] = content;
    data['images'] = images;
    data['video'] = video;
    data['time_video'] = timeVideo;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
