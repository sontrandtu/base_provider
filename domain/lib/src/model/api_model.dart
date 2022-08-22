import 'dart:convert';

import 'dart:io';

class ApiModel<T> {
  int? code;
  String? message;
  T? data;

  ApiModel({this.code, this.message,this.data});

  ApiModel.fromJson(Map<String, dynamic> json, [T Function(dynamic data)? cast]) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) data = cast?.call(json['data']) ?? json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data']= jsonEncode(data);
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

