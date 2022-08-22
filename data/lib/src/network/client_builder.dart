import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

import '../builders/http_builder.dart';

class ClientBuilder extends HttpBuilder {
  late Dio _dio;
  final bool _isDebugMode = true;
  final String _baseUrl = 'https://api.weuptech.vn';
  final int _connectTimeout = 20000;
  final int _receiveTimeout = 20000;
  final int _sendTimeout = 20000;

  ClientBuilder() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
    ))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: _isDebugMode,
        requestBody: _isDebugMode,
        responseBody: _isDebugMode,
        responseHeader: _isDebugMode,
        error: _isDebugMode,
      ));
  }

  @override
  HttpBuilder addBaseUrl(String? baseUrl) {
    if (baseUrl != null) _dio.options.baseUrl = baseUrl;
    return this;
  }

  @override
  HttpBuilder addConnectTimeout(int timeout) {
    _dio.options.connectTimeout = timeout;
    return this;
  }

  @override
  HttpBuilder addReceiveTimeout(int timeout) {
    _dio.options.receiveTimeout = timeout;
    return this;
  }

  @override
  HttpBuilder addSendTimeout(int timeout) {
    _dio.options.sendTimeout = timeout;
    return this;
  }

  @override
  HttpBuilder addDefaultHeaders(Map<String, dynamic> header) {
    _dio.options.headers = header;
    return this;
  }

  @override
  HttpBuilder addHeaders(Map<String, dynamic> header) {
    _dio.options.headers.addAll(header);
    return this;
  }

  @override
  HttpBuilder replaceHeaders(Map<String, dynamic> header) {
    _dio.options.headers = header;
    return this;
  }

  @override
  HttpBuilder addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
    return this;
  }

  @override
  HttpBuilder addCacheDisk({int? ageSeconds, bool? forceReplace}) {
    _dio.interceptors.add(InterceptorDisk(maxAgeSecond: ageSeconds, forceReplace: forceReplace));
    return this;
  }

  @override
  HttpBuilder addCacheMemory({int? ageSeconds, bool? forceReplace}) {
    _dio.interceptors.add(InterceptorMemory(maxAgeSecond: ageSeconds, forceReplace: forceReplace));
    return this;
  }

  @override
  HttpBuilder withConverter<T>({T Function(Map<String, dynamic> json)? fromJson}) {
    _dio.interceptors.add(InterceptorConverter<T>(fromJson: fromJson));
    return this;
  }

  @override
  Dio build() {
    return _dio;
  }

  @override
  HttpBuilder request(
      {String? path,
      String? method,
      Map<String, dynamic>? body,
      FormData? form,
      Map<String, dynamic>? queryParameters}) {
    final _queryParameters = <String, dynamic>{};
    final _data = FormData.fromMap({
      'file': MultipartFile.fromFileSync('./ic_search.png')
    });

    _queryParameters.removeWhere((key, value) => value == null);
   _dio.request(
   '/api/media',
   queryParameters: _queryParameters,
   data: _data,
   options: Options(method: 'POST'),
    );
   return this;
  }
}
