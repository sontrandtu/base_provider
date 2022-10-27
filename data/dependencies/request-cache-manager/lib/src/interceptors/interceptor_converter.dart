import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

import '../common/constants.dart';
import '../managers/request_cache_manager.dart';
import '../models/cache_model.dart';
import 'interceptor_base.dart';

class InterceptorConverter<T> extends InterceptorBase {
  JsonConverter? fromJson;
  final Dio? dio;
  String? _method;
  Map<String, dynamic>? _requestHeader;
  Map<String, dynamic>? _responseHeader;

  void setJsonConverter(JsonConverter? converter) => fromJson = converter;

  InterceptorConverter({this.dio, this.fromJson});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String key = options.path;

    if (forceReplace ?? false) return handler.next(options);

    CacheModel? cache = RequestCacheManager().get(key);

    if (cache == null) return handler.next(options);

    Map<String, dynamic> data = jsonDecode(cache.data);

    _method = options.method;
    _requestHeader = options.headers;
    ApiModel<T> api = ApiModel.fromCache(data,
        data: fromJson?.call(data['data']) ?? data['data'],
        method: _method,
        requestHeader: _requestHeader,
        responseHeader: _responseHeader,
        responseOrigin: data);
    return handler.resolve(Response(requestOptions: options, data: api));
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String key = response.requestOptions.path;
    CacheModel? cache = RequestCacheManager().get(key);
    if (response.statusCode == HttpStatus.notModified && cache != null) {
      Map<String, dynamic> data = jsonDecode(cache.data);
      _method = response.requestOptions.method;
      _requestHeader = response.requestOptions.headers;
      ApiModel<T> api = ApiModel.fromCache(data,
          data: fromJson?.call(data['data']) ?? data['data'],
          method: _method,
          requestHeader: _requestHeader,
          responseHeader: _responseHeader,
          responseOrigin: data);

      return handler.resolve(Response(requestOptions: response.requestOptions, data: api));
    }

    if (response.statusCode != HttpStatus.ok) return handler.next(response);

    _method = response.requestOptions.method;
    _requestHeader = response.requestOptions.headers;
    ApiModel<T> api = ApiModel.fromCache(response.data,
        data: fromJson?.call(response.data['data']) ?? response.data['data'],
        method: _method,
        requestHeader: _requestHeader,
        responseHeader: _responseHeader,
        responseOrigin: response.data);

    print(api.runtimeType);
    return handler.next(Response(data: api, requestOptions: response.requestOptions));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    int? code = err.response?.statusCode ?? CodeConstant.UNKNOWN;
    String? msg = err.response?.statusMessage ?? HttpConstant.UNKNOWN;

    if (err.response?.data is Map<String, dynamic>) {
      if (err.response?.data['code'] != null) code = err.response?.data['code'];
      if (err.response?.data['message'] != null) msg = err.response?.data['message'];
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

    Map<String, dynamic> responseData = {"code": code, "message": msg};
    _method = err.requestOptions.method;
    _requestHeader = err.requestOptions.headers;
    ApiModel<T> api = ApiModel.fromCache(responseData,
        data: fromJson?.call(err.response?.data ?? responseData),
        method: _method,
        requestHeader: _requestHeader,
        responseHeader: _responseHeader,
        responseOrigin: err.response?.data ?? responseData);

    return handler.resolve(Response(requestOptions: err.requestOptions, data: api));
  }
}
