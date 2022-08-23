import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../managers/request_cache_manager.dart';
import '../models/cache_model.dart';
import 'interceptor_base.dart';

class InterceptorConverter<T> extends InterceptorBase {
  final T Function(Map<String, dynamic> json)? fromJson;
  final Dio? dio;

  InterceptorConverter({this.dio, this.fromJson});

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
      return handler.resolve(Response(
          requestOptions: options, data: fromJson?.call(jsonDecode(cache.data)) ?? jsonDecode(cache.data)));
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
        return handler.resolve(Response(
            requestOptions: e.requestOptions,
            data: fromJson?.call(jsonDecode(cache.data)) ?? jsonDecode(cache.data)));
      }
    }

    if (e.statusCode != HttpStatus.ok) return handler.next(e);

    return handler.next(Response(data: fromJson?.call(e.data) ?? e.data, requestOptions: e.requestOptions));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler)async {
    print('----------- DioError Converter - ${err.response?.statusCode} ----------------');

    if (err.error is SocketException) {
      print('Đang chờ mạng');
      late StreamSubscription subscription;
      final completer = Completer<Response>();

      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) return;
        subscription.cancel();
        print('Đã có mạng và request');
        completer.complete(
          dio?.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
              sendTimeout: err.requestOptions.sendTimeout,
              receiveTimeout:  err.requestOptions.receiveTimeout,

            ),
          ),
        );
      });

      return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: fromJson?.call((await completer.future).data) ?? err.response?.data ?? (await completer.future).data));
    }
    print('Thoát kết nối mạng');
    int? code = err.response?.data['code'] ?? err.response?.statusCode ?? -1;
    String? msg = err.response?.data['message'] ?? err.response?.statusMessage ?? 'Đã có lỗi xảy ra';

    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.receiveTimeout) msg = 'Hết thời gian kết nối';

    Map<String, dynamic> responseData = {"code": code, "message": msg};

    return handler.resolve(Response(
        requestOptions: err.requestOptions,
        data: fromJson?.call(responseData) ?? err.response?.data ?? responseData));
  }
}
