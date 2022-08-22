import 'package:dio/dio.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class BasicInterceptor extends InterceptorBase {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.removeWhere((key, value) => value == null);
    return handler.next(options);
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
    return handler.next(e);
  }
}
