import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../managers/request_cache_manager.dart';
import '../models/cache_model.dart';
import 'interceptor_base.dart';

class InterceptorConverter<T> extends InterceptorBase {
  T Function(Map<String, dynamic> json)? fromJson;

  InterceptorConverter({this.fromJson});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('----------- Request Converter ----------------');

    if (forceReplace ?? false) return handler.next(options);

    CacheModel? cache = RequestCacheManager().get(options.path);
    if (cache != null) {
      return handler.resolve(Response(
          requestOptions: options, data: /*fromJson?.call(jsonDecode(cache.data)) ?? */jsonDecode(cache.data)));
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
    print('----------- Response Converter ----------------');
    if (e.statusCode != HttpStatus.ok) return handler.next(e);

    return handler.next(Response(data: /*fromJson?.call(e.data) ??*/ e.data, requestOptions: e.requestOptions));
  }

/*  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('----------- DioError Converter - ${err.response?.statusCode} ----------------');
    int? code = err.response?.statusCode;
    String? msg = err.response?.statusMessage;
    Map<String, dynamic> responseData = {"code": code, "message": msg};

    return handler.resolve(Response(
        requestOptions: err.requestOptions,
        data: fromJson?.call(err.response?.data ?? responseData) ?? err.response?.data ?? responseData));
  }*/
}
