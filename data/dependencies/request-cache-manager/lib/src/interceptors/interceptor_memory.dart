import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
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
    //
    // CacheModel? cache = RequestCacheManager().get(options.path);
    // if (cache != null) {
    //   return handler.resolve(Response(requestOptions: options, data: jsonDecode(cache.data)));
    // }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('----------- Response Memory - ${response.statusCode} ----------------');

    if (response.statusCode != HttpStatus.ok) return handler.next(response);
    String key = response.requestOptions.path;
    List<String>? cacheControl = response.headers['cache-control'];

    String? maxAge =
        cacheControl?.singleWhereOrNull((element) => element.split('=').firstOrNull == 'max-age');
    int? maxAgeValue = int.tryParse(maxAge?.split('=').lastOrNull ?? '');

    print(DateTime.now().add(Duration(seconds: maxAgeValue ?? 60)).millisecondsSinceEpoch ~/ 1000);
    RequestCacheManager().put(
        CacheModel(
            key,
            maxAgeSecond ??
                DateTime.now().add(Duration(seconds: maxAgeValue ?? 60)).millisecondsSinceEpoch ~/ 1000,
            jsonEncode(response.data)),
        forceReplace: forceReplace);
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('----------- DioError Memory - ${err.response?.statusCode} ----------------');
    return handler.next(err);
  }
}
