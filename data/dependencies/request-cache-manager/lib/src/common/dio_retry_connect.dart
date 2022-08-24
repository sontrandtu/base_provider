import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioRetryConnect {
  final Dio? dio;
  final DioError? err;

  DioRetryConnect({this.dio, this.err});

  Future<Response> onRetry() async {
    late StreamSubscription subscription;
    Completer completer = Completer<Response>();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) return;
      subscription.cancel();
      completer.complete(_request);
    });
    return await completer.future;
  }

  void _request() {
    Options options = Options(
        method: err?.requestOptions.method,
        headers: err?.requestOptions.headers,
        sendTimeout: err?.requestOptions.sendTimeout,
        receiveTimeout: err?.requestOptions.receiveTimeout);

    dio?.request(
      err?.requestOptions.path ?? '',
      data: err?.requestOptions.data,
      queryParameters: err?.requestOptions.queryParameters,
      options: options,
    );
  }
}
