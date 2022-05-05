import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/page_manager/app_navigator.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/resource/enum_resource.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  Status _status = Status.loading;

  RouteSettings? _settings;

  BuildContext? _context;

  AppNavigator? _appNavigator = AppNavigator();

  /// ---------------------------------------------------

  AppNavigator get appNavigator => _appNavigator!;

  Status get status => _status;

  // BuildContext get context => _context!;

  String? get currentRoute => _settings?.name;

  Future<bool> get isConnecting async => await getConnection();

  /// -----------------------------------------------------

  dynamic getArguments() => _settings?.arguments;

  Future<void> initialData() async => await fetchData();

  @mustCallSuper
  Future<void> fetchData() async {
    if (await getConnection(reconnect: fetchData)) return;
  }

  void onViewCreated() {}

  Future<void> delay(int millis) async => await Future.delayed(Duration(milliseconds: millis));

  Future<bool> getConnection({Function? reconnect}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      appNavigator.dialog(BaseErrorDialog(
        content: HttpConstant.CONNECT_ERROR,
        textButtonConfirm: 'Thử lại',
        mConfirm: reconnect ?? appNavigator.back,
        mCancel: appNavigator.back,
      ));
      setStatus(Status.error);

      return true;
    }
  }

  void setStatus(Status s) {
    _status = s;
    update();
  }

  void setRouteSetting(RouteSettings? rs) => _settings = rs;

  void setBuildContext(BuildContext? ctx) {
    _context = ctx;
    _appNavigator?.setBuildContext(ctx);
  }

  bool checkNull(ApiResponse? value, {bool isInitial = true}) {
    if (value?.data != null) return false;

    setStatus(isInitial ? Status.errorInit : Status.error);

    setErrorMessage(value?.message);

    return true;
  }

  void setErrorMessage(dynamic msg) {
    appNavigator.dialog(BaseErrorDialog(content: msg, showCancel: false));
    ViewUtils.toast(msg);
  }

  void update() => notifyListeners();

  @mustCallSuper
  void onDispose() {
    _appNavigator = null;
  }
}
