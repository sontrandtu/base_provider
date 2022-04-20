import 'package:achitech_weup/common/core/base_function.dart';
import 'package:achitech_weup/common/network/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  static String _BASE_URL = 'https://hidelink.vn';

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
        headers: {},
        contentType: _CONTENT_TYPE));

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
