import 'package:achitecture_weup/common/core/sys/base_function.dart';
import 'package:achitecture_weup/common/network/service.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Client {
  static String _BASE_URL = 'https://dominhduong.weuptech.vn/cms/api/v1';
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
    final CookieJar cookieJar = CookieJar();
    _dio?.interceptors.add(CookieManager(cookieJar));

    _dio?.interceptors.add(InterceptorsWrapper(onResponse: (response, handler) {
      _dio = null;
      return handler.next(response);
    }, onError: (error, handler) {
      _dio = null;
      return handler.next(error);
    }));
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
}
