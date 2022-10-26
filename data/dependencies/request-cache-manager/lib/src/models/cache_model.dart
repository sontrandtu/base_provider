class CacheModel extends BaseModel{
  late String key;
  late int age;
  late String data;
  String? userId;

  CacheModel(this.key, this.age, this.data, {this.userId});

  CacheModel.fromJson(Map<String, dynamic> json) {
    key = json['key'] ?? '';
    userId = json['userId'] ?? '';
    age = json['age'] ?? 0;
    data = json['data'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['user_id'] = userId;
    data['age'] = age;
    data['data'] = this.data;
    return data;
  }

  @override
  String toString() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['age'] = age;
    map['data'] = data;
    map['user_id'] = userId;
    return map.toString();
  }

}

abstract class BaseModel{


  BaseModel.fromJson(Map<String, dynamic> json);

  BaseModel();
}
