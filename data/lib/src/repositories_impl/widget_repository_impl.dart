import 'dart:io';

import 'package:data/src/common/constants.dart';
import 'package:data/src/common/dio_extensiton.dart';
import 'package:data/src/network/api_paths.dart';
import 'package:data/src/network/client_builder.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class WidgetRepositoryImpl implements WidgetRepository {
  WidgetRepositoryImpl._internal();

  static final WidgetRepositoryImpl _instance = WidgetRepositoryImpl._internal();

  factory WidgetRepositoryImpl() => _instance;

  @override
  Future<dynamic> getShareApp() async {
    final _queryParameters = <String, dynamic>{};
    final _data = {
      'phone': '0943574556',
      'password': '19022001',
      'file': [File('./ic_search.png')]
    };

    return await ClientBuilder()
        .addCacheMemory()
        .withConverter(fromJson: (json) => ApiModel.fromJson(json, (json) => UserDetailModel.fromJson(json)))
        .request<ApiModel<UserDetailModel>>('/v1/login',
            method: Method.POST, dataType: DataType.FORM_DATA, params: _queryParameters, bodies: _data)
        .wrap();
  }

  @override
  Future saveFile() async {
    final _queryParameters = <String, dynamic>{};
    final _data = FormData.fromMap({
      'file': [MultipartFile.fromFileSync('./ic_search.png'), MultipartFile.fromFileSync('./ic_search.png')]
    });

    _queryParameters.removeWhere((key, value) => value == null);

    return await ClientBuilder()
        .addBaseUrl('https://app.weuptech.vn')
        .addCacheMemory()
        .withConverter<ApiModel>(
            fromJson: (json) => ApiModel.fromJson(
                  json,
                ))
        .build()
        .post('/api/media', queryParameters: _queryParameters, data: _data);
  }

  @override
  Future addFeeling() async {
    final paths = {'lessonId': '1654649615pa1g8zjyf79v'};
    final bodies = {
      'images': ['123', '123'],
      'content': 'Bài học hay'
    };
    return await ClientBuilder()
        .withConverter<ApiModel>(fromJson: (json) => ApiModel.fromJson(json))
        .request<ApiModel>(ApiPaths.ADD_FEELING, method: Method.POST, paths: paths, bodies: bodies)
        .wrap();
  }

  @override
  Future getAllFeeling() async {
    final paths = {'lessonId': '1654649615pa1g8zjyf79v'};
    return await ClientBuilder()
        .addCacheMemory()
        .withConverter<ApiModel<List<FeelingModel>>>(
            fromJson: (json) => ApiModel.fromJson(
                json, (data) => data.map<FeelingModel>((element) => FeelingModel.fromJson(element)).toList()))
        .request<ApiModel<List<FeelingModel>>>(ApiPaths.FEELINGS, paths: paths)
        .wrap();
  }
}

