import 'dart:convert';

class ApiModel<T> {
  int? code;
  String? message;
  String? method;
  Map<String, dynamic>? requestHeader;
  Map<String, dynamic>? responseHeader;
  dynamic responseOrigin;
  T? data;

  ApiModel({this.code, this.message, this.data, this.requestHeader, this.method, this.responseHeader, this.responseOrigin});

  ApiModel.fromCache(Map<String, dynamic> json, {this.data, this.method, this.requestHeader, this.responseHeader, this.responseOrigin}) {
    code = json['code'];
    message = json['message'];
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
