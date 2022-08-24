import 'dart:io';

import 'package:data/src/common/constants.dart';
import 'package:data/src/common/header_config.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

import '../builders/http_builder.dart';

class ClientBuilder extends HttpBuilder {
  late Dio _dio;
  PrettyDioLogger? _logger;
  BasicInterceptor? _basicInterceptor;
  final bool _isDebugMode = true;
  final String _baseUrl = 'https://api.weuptech.vn';
  final int _connectTimeout = 10000;
  final int _receiveTimeout = 10000;
  final int _sendTimeout = 10000;

  ClientBuilder() {
    _logger ??= PrettyDioLogger(
        requestHeader: _isDebugMode,
        requestBody: _isDebugMode,
        responseBody: _isDebugMode,
        responseHeader: _isDebugMode,
        error: _isDebugMode);

    _basicInterceptor ??= BasicInterceptor();

    _dio = Dio(BaseOptions(
        baseUrl: _baseUrl,
        headers: HeaderConfig().getHeaders(),
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout))
      ..interceptors.addAll([_logger!, _basicInterceptor!]);
  }

  /*
  * Custom 1 url khác
  * */
  @override
  HttpBuilder addBaseUrl(String? baseUrl) {
    if (baseUrl != null) _dio.options.baseUrl = baseUrl;
    return this;
  }

  /*
  * Custom thời gian timeout
  * */
  @override
  HttpBuilder addConnectTimeout(int timeout) {
    _dio.options.connectTimeout = timeout;
    return this;
  }

  /*
  * Custom thời gian timeout
  * */
  @override
  HttpBuilder addReceiveTimeout(int timeout) {
    _dio.options.receiveTimeout = timeout;
    return this;
  }

  /*
  * Custom thời gian timeout
  * */
  @override
  HttpBuilder addSendTimeout(int timeout) {
    _dio.options.sendTimeout = timeout;
    return this;
  }

  @Deprecated('Do not use this function. Default header is HeaderConfig().getHeader()')
  @override
  HttpBuilder addDefaultHeaders(Map<String, dynamic> header) {
    _dio.options.headers = header;
    return this;
  }

  /*
  * Thêm headers
  * */
  @override
  HttpBuilder addHeaders(Map<String, dynamic> header) {
    _dio.options.headers.addAll(header);
    return this;
  }

  /*
  * Ghi đè headers
  * */
  @override
  HttpBuilder replaceHeaders(Map<String, dynamic> header) {
    _dio.options.headers = header;
    return this;
  }

  /*
  * Thêm 1 interceptor khác
  * */
  @override
  HttpBuilder addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
    return this;
  }

  /*
  * Thêm cache vào file
  * */
  @override
  HttpBuilder addCacheDisk({int? ageSeconds, bool? forceReplace}) {
    _dio.interceptors.add(InterceptorDisk(maxAgeSecond: ageSeconds, forceReplace: forceReplace));
    return this;
  }

  /*
  * Thêm cache vào ram
  * */
  @override
  HttpBuilder addCacheMemory({int? ageSeconds, bool? forceReplace}) {
    _dio.interceptors.add(InterceptorMemory(maxAgeSecond: ageSeconds, forceReplace: forceReplace));
    return this;
  }

  /*
  *  Luôn gọi đến converter để parse json sang object hoặc lấy từ cache, hoặc lấy json thuần
  * */
  @override
  HttpBuilder withConverter<T>({T Function(dynamic json)? fromJson}) {
    _dio.interceptors.add(InterceptorConverter<T>(fromJson: fromJson,dio: _dio));

    return this;
  }

  @override
  HttpBuilder withConverterRestful<T>({T Function(dynamic json)? fromJson}) {
    _dio.interceptors.add(InterceptorConverterRestful<T>(fromJson: fromJson,dio: _dio));
    return this;
  }
  /*
  *  Xây dựng lên đối tượng dio
  * */
  @override
  Dio build() {
    return _dio;
  }

  /*
  *  Gọi request bằng hàm này để sử dụng các tiện ích
  *
  *  Nếu truyền lên file thì chỉ cần truyền vào body file: {'file': [File('./ic_search.png')]} hoặc {'file': File('./ic_search.png')}
  *  Nếu truyền lên List<String> thì chỉ cần truyền vào body file:   {'images': ['string1', 'string2']}
  *  Nếu truyền raw json thông thường thì chỉ cần truyền lên map {'key':'value'}
  *
  *  Khi api có Patch thì truyền vào paths với key trùng với key ở url:
  *  url: '/v1/lesson-contact-comment/{lessonId}'
  *  paths: {'lessonId': '1654649615pa1g8zjyf79v'}
  *
  *  Method mặc định là GET
  * */
  @override
  Future<Response<T>> request<T>(String path,
      {String? method,
      String? dataType = DataType.FORM_DATA,
      dynamic bodies,
      Map<String, dynamic>? paths,
      Map<String, dynamic>? params}) async {
    paths?.forEach((key, value) => path = path.replaceAll('{$key}', value.toString()));

    bodies ??= <String, dynamic>{};

    bodies?.removeWhere((key, value) => value == null);

    params?.removeWhere((key, value) => value == null);

    dynamic _data;

    switch (dataType) {
      case DataType.FORM_DATA:
        bodies.forEach((key, value) {
          if (value is List<File>) value = value.map((e) => MultipartFile.fromFileSync(e.path)).toList();
          if (value is File) value = MultipartFile.fromFileSync(value.path);
        });
        _data = FormData.fromMap(bodies);
        break;
      case DataType.JSON:
        _data = bodies;
        break;
      default:
        _data = bodies;
    }

    return await _dio.request<T>(path, queryParameters: params, data: _data, options: Options(method: method,extra: {'data':'extra'}));
  }  @override
  Future<Response<T>> requestRestful<T>(String path,
      {String? method,
      String? dataType = DataType.FORM_DATA,
      dynamic bodies,
      Map<String, dynamic>? paths,
      Map<String, dynamic>? params}) async {
    paths?.forEach((key, value) => path = path.replaceAll('{$key}', value.toString()));

    bodies ??= <String, dynamic>{};

    bodies?.removeWhere((key, value) => value == null);

    params?.removeWhere((key, value) => value == null);

    dynamic _data;

    switch (dataType) {
      case DataType.FORM_DATA:
        bodies.forEach((key, value) {
          if (value is List<File>) value = value.map((e) => MultipartFile.fromFileSync(e.path)).toList();
          if (value is File) value = MultipartFile.fromFileSync(value.path);
        });
        _data = FormData.fromMap(bodies);
        break;
      case DataType.JSON:
        _data = bodies;
        break;
      default:
        _data = bodies;
    }

    return await _dio.request<T>(path, queryParameters: params, data: _data, options: Options(method: method,extra: {'data':'extra'}));
  }

}
