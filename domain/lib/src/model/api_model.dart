import 'dart:convert';

class ApiModel<T> {
  int? code;
  String? message;
  String? method;
  Map<String,dynamic>? requestHeader;
  Map<String,dynamic>? responseHeader;
  dynamic responseOrigin;
  T? data;

  ApiModel(
      {this.code,
      this.message,
      this.data,
      this.requestHeader,
      this.method,
      this.responseHeader,
      this.responseOrigin});

  ApiModel.fromJson(Map<String, dynamic> json, [T Function(dynamic data)? cast]) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) data = cast?.call(json['data']) ?? json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = jsonEncode(data);
    return data;
  }

  @override
  String toString() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['data'] = jsonEncode(data);
    return map.toString();
  }
}
