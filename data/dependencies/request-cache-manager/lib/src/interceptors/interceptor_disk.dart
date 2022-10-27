import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:request_cache_manager/src/managers/cache_manager_factory.dart';

import '../managers/request_cache_disk_manager.dart';
import '../models/cache_model.dart';
import 'interceptor_base.dart';

class InterceptorDisk extends InterceptorBase {
  InterceptorDisk({int? maxAgeSecond, bool? forceReplace}) : super(maxAgeSecond: maxAgeSecond, forceReplace: forceReplace);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('----------- Request Disk ----------------');

    if (forceReplace ?? false) return handler.next(options);

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('----------- Response Disk ----------------');
    if (response.statusCode != HttpStatus.ok) return handler.next(response);
    String key = response.requestOptions.path;
    List<String>? cacheControl = response.headers['cache-control'];

    String? maxAge = cacheControl?.singleWhereOrNull((element) => element.split('=').firstOrNull == 'max-age');
    int? maxAgeValue = int.tryParse(maxAge?.split('=').lastOrNull ?? '');

    CacheManagerFactory.disk().put(CacheModel(
        key, maxAgeSecond ?? DateTime.now().add(Duration(seconds: maxAgeValue ?? 60)).millisecondsSinceEpoch ~/ 1000, jsonEncode(response.data)));

    return handler.next(response);
  }
}
