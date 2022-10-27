import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../common/constants.dart';
import '../../managers/request_cache_manager.dart';
import '../../models/cache_model.dart';
import '../interceptor_base.dart';

typedef JsonConverter<T> = T Function(dynamic json);

class InterceptorConverterRestful extends InterceptorBase {
  JsonConverter? fromJson;
  final Dio? dio;
  int? _code;
  String? _message;
  dynamic _data;
  String? _method;
  Map<String, dynamic>? _requestHeader;
  Map<String, dynamic>? _responseHeader;
  dynamic _responseOrigin;

  void setJsonConverter(JsonConverter? converter) => fromJson = converter;

  InterceptorConverterRestful({this.dio, this.fromJson});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('----------- Request Converter ----------------');
    String key = options.path;
    switch (options.method) {
      case 'POST':
      case 'PUT':
      case 'PATCH':
      case 'DELETE':
        RequestCacheManager().remove(key);
    }

    if (forceReplace ?? false) return handler.next(options);

    print('KEY Converter: $key');

    CacheModel? cache = RequestCacheManager().get(key);

    if (cache != null) {
      _code = CodeConstant.OK;
      _message = HttpConstant.SUCCESS;
      _method = options.method;
      _requestHeader = options.headers;
      _data = fromJson?.call(jsonDecode(cache.data)) ?? jsonDecode(cache.data);
      _responseOrigin = jsonDecode(cache.data);
      ApiModel api = ApiModel(
          code: _code,
          data: _data,
          method: _method,
          message: _message,
          requestHeader: _requestHeader,
          responseHeader: _responseHeader,
          responseOrigin: _responseOrigin);

      return handler.resolve(Response(requestOptions: options, data: api));
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('----------- Response Converter ----------------');
    _code = response.data['code'] ?? CodeConstant.OK;
    _message = response.data['message'] ?? HttpConstant.SUCCESS;
    _method = response.requestOptions.method;
    _requestHeader = response.requestOptions.headers;

    if (response.statusCode == HttpStatus.notModified) {
      String key = response.requestOptions.path;
      CacheModel? cache = RequestCacheManager().get(key);
      if (cache != null) {
        _data = fromJson?.call(jsonDecode(cache.data)) ?? jsonDecode(cache.data);
        _responseOrigin = jsonDecode(cache.data);

        ApiModel api = ApiModel(
            code: _code,
            data: _data,
            method: _method,
            message: _message,
            requestHeader: _requestHeader,
            responseHeader: _responseHeader,
            responseOrigin: _responseOrigin);
        return handler.resolve(Response(requestOptions: response.requestOptions, data: api));
      }
    }

    if (response.statusCode != HttpStatus.ok) return handler.next(response);

    _data = fromJson?.call(response.data) ?? response.data;
    _responseOrigin = response.data;

    ApiModel api = ApiModel(
        code: _code,
        data: _data,
        method: _method,
        message: _message,
        requestHeader: _requestHeader,
        responseHeader: _responseHeader,
        responseOrigin: _responseOrigin);

    return handler.next(Response<ApiModel?>(data: api, requestOptions: response.requestOptions));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('----------- DioError Converter - ${err.response?.statusCode} ----------------');

    int? code = err.response?.statusCode ?? CodeConstant.UNKNOWN;
    String? msg = err.response?.statusMessage ?? HttpConstant.UNKNOWN;

    if (err.response?.data is Map) {
      var _code = err.response?.data['code'];
      var _msg = err.response?.data['message'];
      if (_code! is int) code = int.tryParse(_code.toString());
      if (_msg! is String) msg = jsonEncode(_msg);
    }

    if (err.error is SocketException) {
      code = CodeConstant.CONNECT_ERROR;
      msg = HttpConstant.CONNECT_ERROR;

      // Response response = await DioRetryConnect(dio: dio, err: err).onRetry();
      // return handler.resolve(response);
    }

    bool isConnectTimeout = err.type == DioErrorType.connectTimeout;
    bool isSendTimeout = err.type == DioErrorType.sendTimeout;
    bool isReceiveTimeout = err.type == DioErrorType.receiveTimeout;

    if (isConnectTimeout || isSendTimeout || isReceiveTimeout) {
      code = CodeConstant.TIME_OUT;
      msg = HttpConstant.TIME_OUT;
    }

    _code = code;
    _message = msg;
    _method = err.requestOptions.method;
    _requestHeader = err.requestOptions.headers;

    ApiModel api = ApiModel(
        code: _code,
        data: _data,
        method: _method,
        message: _message,
        requestHeader: _requestHeader,
        responseHeader: _responseHeader,
        responseOrigin: _responseOrigin);

    return handler.resolve(Response(requestOptions: err.requestOptions, data: api));
  }
}
