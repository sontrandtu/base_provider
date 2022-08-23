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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_id'] = this.contactId;
    data['course_id'] = this.courseId;
    data['course_lesson_id'] = this.courseLessonId;
    data['contact_name'] = this.contactName;
    data['contact_avatar'] = this.contactAvatar;
    data['content'] = this.content;
    data['images'] = this.images;
    data['video'] = this.video;
    data['time_video'] = this.timeVideo;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
