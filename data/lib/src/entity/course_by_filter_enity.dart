class CourseByFilterEntity {
  String? id;
  int? idInt;
  String? name;
  String? image;
  bool? isFavorite;
  String? state;
  int? totalLesson;
  int? totalLessonDone;
  int? totalContentDone;
  int? progress;
  String? timeDone;
  String? lessonId;
  String? lessonName;

  CourseByFilterEntity({
    this.id,
    this.idInt,
    this.name,
    this.image,
    this.isFavorite,
    this.state,
    this.totalLesson,
    this.totalLessonDone,
    this.totalContentDone,
    this.progress,
    this.timeDone,
    this.lessonId,
    this.lessonName,
  });

  CourseByFilterEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInt = json['id_int'];
    name = json['name'];
    image = json['image'];
    isFavorite = json['is_favorite'];
    state = json['state'];
    totalLesson = json['total_lesson'];
    totalLessonDone = json['total_lesson_done'];
    totalContentDone = json['total_content_done'];
    progress = json['progress'];
    timeDone = json['time_done'];
    lessonId = json['lesson_id'];
    lessonName = json['lesson_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_int'] = idInt;
    data['name'] = name;
    data['image'] = image;
    data['is_favorite'] = isFavorite;
    data['state'] = state;
    data['total_lesson'] = totalLesson;
    data['total_lesson_done'] = totalLessonDone;
    data['total_content_done'] = totalContentDone;
    data['progress'] = progress;
    data['time_done'] = timeDone;
    data['lesson_id'] = lessonId;
    data['lesson_name'] = lessonName;
    return data;
  }
}
