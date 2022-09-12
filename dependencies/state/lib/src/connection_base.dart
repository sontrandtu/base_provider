import 'dart:io';

mixin ConnectionBase{

  Future<bool> get isConnecting async => await getConnection();

/*
  * Kiểm tra connect internet, thường được kiểm tra 1 lần trước
  * khi thực hiện các request
  * */
  Future<bool> getConnection({Function()? reconnect}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      // appNavigator.dialog(BaseErrorDialog(
      //   content: HttpConstant.CONNECT_ERROR,
      //   textButtonConfirm: 'Thử lại',
      //   mConfirm: () {
      //     setStatus(Status.loading);
      //     reconnect ?? appNavigator.back();
      //   },
      //   mCancel: appNavigator.back,
      // ));
      // _status = Status.connection;
      //
      // if (flagLifecycle == Lifecycle.BUILD) _status = Status.error;
      // update();

      return true;
    }
  }
}