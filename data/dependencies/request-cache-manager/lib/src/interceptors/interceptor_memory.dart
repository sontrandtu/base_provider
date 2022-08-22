import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../managers/request_cache_manager.dart';
import '../models/cache_model.dart';
import 'interceptor_base.dart';

class InterceptorMemory extends InterceptorBase {
  InterceptorMemory({int? maxAgeSecond, bool? forceReplace})
      : super(forceReplace: forceReplace, maxAgeSecond: maxAgeSecond);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('----------- Request Memory ----------------');

    if (forceReplace ?? false) return handler.next(options);

    CacheModel? cache = RequestCacheManager().get(options.path);
    if (cache != null) {
      return handler.resolve(Response(requestOptions: options, data: jsonDecode(cache.data)));
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
    print('----------- Response Memory - ${e.statusCode} ----------------');

    if (e.statusCode != HttpStatus.ok) return handler.next(e);

    RequestCacheManager().put(
        CacheModel(
            e.requestOptions.path,
            maxAgeSecond ?? DateTime.now().add(Duration(minutes: 1)).millisecondsSinceEpoch ~/ 1000,
            jsonEncode(e.data)),
        forceReplace: forceReplace);

    return handler.next(e);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('----------- DioError Memory - ${err.response?.statusCode} ----------------');
    return handler.next(err);
  }
}
