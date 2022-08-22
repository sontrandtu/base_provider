import 'dart:io';

import 'package:data/src/network/client_builder.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class WidgetRepositoryImpl implements WidgetRepository {
  WidgetRepositoryImpl._internal();

  static final WidgetRepositoryImpl _instance = WidgetRepositoryImpl._internal();

  factory WidgetRepositoryImpl() => _instance;

  @override
  Future<dynamic> getShareApp() async {
    final _queryParameters = <String, dynamic>{};
    final _data = FormData.fromMap({
      'phone': '0987654321',
      'password': '123456',
      'files': [File('path/file.ok'), File('path/file.ok')]
    });

    _queryParameters.removeWhere((key, value) => value == null);

    return await ClientBuilder()
        .addCacheMemory()
        .withConverter<ApiModel>(fromJson: (json) => ApiModel.fromJson(json))
        .build()
        .request(
          '/v1/login',
          queryParameters: _queryParameters,
          data: _data,
          options: Options(method: 'POST'),
        );
  }
  @override
  Future saveFile() async{
    final _queryParameters = <String, dynamic>{};
    final _data = FormData.fromMap({
      'file': MultipartFile.fromFileSync('./ic_search.png')
    });

    _queryParameters.removeWhere((key, value) => value == null);

    return await ClientBuilder()
    .addBaseUrl('https://app.weuptech.vn')
        .addCacheMemory()
        .withConverter<ApiModel>(fromJson: (json) => ApiModel.fromJson(json))
        .build()
        .request(
      '/api/media',
      queryParameters: _queryParameters,
      data: _data,
      options: Options(method: 'POST'),
    );
  }
}

main() async {
  var i;
  do {
    var response = await WidgetRepositoryImpl().saveFile();
    print(response.runtimeType);
    i = stdin.readLineSync();
  } while (i == '0');
}
