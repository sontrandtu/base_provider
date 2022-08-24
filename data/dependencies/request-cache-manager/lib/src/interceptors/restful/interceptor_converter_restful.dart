import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../../common/constants.dart';
import '../../managers/request_cache_manager.dart';
import '../../models/cache_model.dart';
import '../interceptor_base.dart';

class InterceptorConverterRestful<T> extends InterceptorBase {
  final T Function(dynamic json)? fromJson;
  final Dio? dio;

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
      ApiModel api = ApiModel<T>(
          code: CodeConstant.OK, data: fromJson?.call(jsonDecode(cache.data)) ?? jsonDecode(cache.data));

      return handler.resolve(Response(requestOptions: options, data: api));
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
    print('----------- Response Converter ----------------');

    if (e.statusCode == HttpStatus.notModified) {
      String key = e.requestOptions.path;
      CacheModel? cache = RequestCacheManager().get(key);
      if (cache != null) {
        ApiModel api = ApiModel<T>(
            code: CodeConstant.OK, data: fromJson?.call(jsonDecode(cache.data)) ?? jsonDecode(cache.data));
        return handler.resolve(Response(requestOptions: e.requestOptions, data: api));
      }
    }

    if (e.statusCode != HttpStatus.ok) return handler.next(e);

    ApiModel api = ApiModel<T>(code: CodeConstant.OK, data: fromJson?.call(e.data) ?? e.data);

    return handler.next(Response<ApiModel?>(data: api, requestOptions: e.requestOptions));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('----------- DioError Converter - ${err.response?.statusCode} ----------------');

    int? code = err.response?.data['code'] ?? err.response?.statusCode ?? CodeConstant.UNKNOWN;
    String? msg = err.response?.data['message'] ?? err.response?.statusMessage ?? HttpConstant.UNKNOWN;

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

    ApiModel api = ApiModel<T>(code: code, message: msg);

    return handler.resolve(Response(requestOptions: err.requestOptions, data: api));
  }
}
