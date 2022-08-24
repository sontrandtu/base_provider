import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

import '../managers/request_cache_disk_manager.dart';
import '../models/cache_model.dart';
import 'interceptor_base.dart';

class InterceptorDisk extends InterceptorBase {
  InterceptorDisk({int? maxAgeSecond, bool? forceReplace})
      : super(maxAgeSecond: maxAgeSecond, forceReplace: forceReplace);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('----------- Request Disk ----------------');

    if (forceReplace ?? false) return handler.next(options);

    // CacheModel? cache = RequestCacheDiskManager().get(options.path);
    // if (cache != null) {
    //   return handler.resolve(Response(requestOptions: options, data: jsonDecode(cache.data)));
    // }
    return handler.next(options);
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
    print('----------- Response Disk ----------------');
    if (e.statusCode != HttpStatus.ok) return handler.next(e);
    String key = e.requestOptions.path;
    print('KEY: $key');

    List<String>? cacheControl = e.headers['cache-control'];

    String? maxAge =
        cacheControl?.singleWhereOrNull((element) => element.split('=').firstOrNull == 'max-age');
    int? maxAgeValue = int.tryParse(maxAge?.split('=').lastOrNull ?? '');

    RequestCacheDiskManager().put(
        CacheModel(
            key,
            maxAgeSecond ??
                DateTime.now().add(Duration(seconds: maxAgeValue ?? 60)).millisecondsSinceEpoch ~/ 1000,
            jsonEncode(e.data)),
        forceReplace: forceReplace);

    return handler.next(e);
  }
}
