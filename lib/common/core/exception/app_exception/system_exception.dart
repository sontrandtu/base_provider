import 'package:flutter/material.dart';

class SystemException {
  BuildContext? context;

  SystemException({this.context});

  void catchFutureError(Object error, StackTrace stack) {
    // showError(error);
    // showDialog(
    //     builder: (_) => BaseErrorDialog(
    //           content: stack.toString(),
    //         ),
    //     context: Application.navigator.currentContext!);
  }

  void catchError(FlutterErrorDetails details) {
    // showError(details.exception);
    // showDialog(
    //     builder: (_) => BaseErrorDialog(
    //           content: details.stack.toString(),
    //         ),
    //     context: context!);
  }
}
