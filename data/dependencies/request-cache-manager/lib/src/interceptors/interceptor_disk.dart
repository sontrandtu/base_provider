import 'dart:convert';
import 'dart:io';

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

    if(forceReplace ?? false) return handler.next(options);

    // CacheModel? cache = RequestCacheDiskManager().get(options.path);
    // if (cache != null) {
    //   return handler.resolve(Response(requestOptions: options, data: jsonDecode(cache.data)));
    // }
    return handler.next(options);
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
    print('----------- Response Disk ----------------');
    if(e.statusCode != HttpStatus.ok) return handler.next(e);

    RequestCacheDiskManager().put(
        CacheModel(
            e.requestOptions.path,
            maxAgeSecond ?? DateTime.now().add(Duration(minutes: 1)).millisecondsSinceEpoch ~/ 1000,
            jsonEncode(e.data)),
        forceReplace: forceReplace);

    return handler.next(e);
  }
}
