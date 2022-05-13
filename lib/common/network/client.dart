import 'package:achitecture_weup/common/core/sys/base_function.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/local_storage/local_storage.dart';
import 'package:achitecture_weup/common/network/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  static String _BASE_URL = 'https://jsonplaceholder.typicode.com';
  static const int _CONNECT_TIMEOUT = 20000;
  static const int _RECEIVE_TIMEOUT = 20000;
  static const String _CONTENT_TYPE = 'application/json';
  static Dio? _dio;
  static Service? _service;

  static Service getClient() {
    return _service = Service(_configDio());
  }

  static Dio _configDio() {
    _dio = Dio(BaseOptions(
        baseUrl: _BASE_URL,
        connectTimeout: _CONNECT_TIMEOUT,
        receiveTimeout: _RECEIVE_TIMEOUT,
        headers: {'id': '-1'},
        contentType: _CONTENT_TYPE));

    _dio?.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequestCache, onResponse: _onResponseCache, onError: _onErrorCache));

    if (kDebugMode) {
      _dio?.interceptors.add(PrettyDioLogger(
          logPrint: _logPrint,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true));
    }
    return _dio!;
  }

  void setUrl(String? url) {
    if (url != null) {
      _BASE_URL = url;
    }
  }

  static void _logPrint(v) {
    showDioLog(v);
  }

  static void _onRequestCache(RequestOptions options, RequestInterceptorHandler handler) async {

    handler.next(options);
  }

  static void _onResponseCache(Response response, ResponseInterceptorHandler handler) {
    _dio = null;
    handler.next(response);
  }

  static void _onErrorCache(DioError error, ErrorInterceptorHandler handler) {
    _dio = null;
    handler.next(error);
  }
}
