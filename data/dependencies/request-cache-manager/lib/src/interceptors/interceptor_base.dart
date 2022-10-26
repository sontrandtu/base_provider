import 'package:dio/dio.dart';

abstract class InterceptorBase extends Interceptor {
  int? maxAgeSecond;
  bool? forceReplace;

  InterceptorBase({this.maxAgeSecond, this.forceReplace});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) => handler.next(err);
}
