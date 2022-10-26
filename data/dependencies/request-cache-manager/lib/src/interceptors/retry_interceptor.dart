import 'package:request_cache_manager/request_cache_manager.dart';

class RetryInterceptor extends BasicInterceptor {
  late final Dio dio;


  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
//     if(err.error is! SocketException) return handler.next(err);
//     late StreamSubscription subscription;
//     final completer = Completer<Response>();
//     subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       subscription.cancel();
//       completer.complete(
//
//       )
//     });
// return completer.future;
  }

/* @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  }

  @override
  void onResponse(Response e, ResponseInterceptorHandler handler) {
  }*/

}
