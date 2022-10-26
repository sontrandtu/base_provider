import 'dart:async';

import 'package:request_cache_manager/request_cache_manager.dart';

class BasicInterceptor extends InterceptorBase {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters.removeWhere((key, value) => value == null);

    options.queryParameters.removeWhere((key, value) => value.toString().isEmpty);

    if (options.data is FormData) {
      options.data.fields.removeWhere((element) => element.value.toString().isEmpty);
    }

    final Map<String, dynamic>? paths = options.extra[ExtraKey.PATHS];
    final List<String> keys = options.extra[ExtraKey.KEYS]?.cast<String>() ?? [];

    paths?.forEach((key, value) {
      options.path = options.path.replaceAll('{$key}', value.toString());
      for (var element in keys) {
        element = element.replaceAll('{$key}',  value.toString());
      }
    });

    await Future.forEach(keys, _clearCaches);

    final String key = options.path;
    // switch (options.method) {
    //   case Method.POST.name:
    //   case MethodText.PUT:
    //   case MethodText.PATCH:
    //   case MethodText.DELETE:
    //     RequestCacheManager().remove(key);
    // }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  FutureOr _clearCaches(String element) async {
    await RequestCacheManager().remove(element);
  }
}
