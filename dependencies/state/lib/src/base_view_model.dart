import 'dart:io';

import 'package:flutter/material.dart';
import 'package:state/src/constants.dart';
import 'package:state/src/status.dart';
import 'package:widgets/widgets.dart';

import 'app_navigator.dart';
import 'lifecycle_base.dart';

abstract class BaseViewModel extends ChangeNotifier with LifecycleBase {
  Status _status = Status.loading;

  AppNavigator appNavigator = AppNavigator();

  BuildContext get context => appNavigator.context;

  /*
  * Trạng thái của view
  * */
  Status get status => _status;

  /*
  * Hàm dùng để call api ngay sau khi [initialData] được
  * sử dụng khi [initialData] có [supper]
  * */

  Future<void> fetchData() async {}

  /*
  * Hỗ trợ nhanh delay một khoảng thời gian,
  * thường được sử dụng trong môi trường dev
  * */
  Future<void> delay(int millis) async => await Future.delayed(Duration(milliseconds: millis));

  /*
  * Thay đổi lại trạng thái của giao diện
  * */
  void setStatus(Status s) {
    _status = s;
    update();
  }

  /*
  * Lấy ra context và argument, phục vụ navigation, [getArgument]
  *
  * Không cần đến context trong [ViewModel]
  * */
  void setBuildContext(BuildContext ctx) {
    appNavigator = AppNavigator();

    appNavigator.setBuildContext(ctx);
  }


  bool checkStatus(dynamic value, {bool isShowDialog = true}) {
    if (value.code == CodeConstant.OK) return false;

    // HandleHttpException(code: value.err?.code, appNavigator: appNavigator).catchError();

    // if (value.err?.code == CodeConstant.INVALID_SIGN) return true;

    if (flagLifecycle == Lifecycle.INIT) {
      _status = Status.firstIssue;
      if (value.code == CodeConstant.CONNECT_ERROR) _status = Status.connection;
    }

    if (flagLifecycle == Lifecycle.BUILD) _status = Status.error;

    update();

    if (!isShowDialog) return true;

    setErrorMessage(value.message);

    return true;
  }

  /*
  * Thực hiện show dialog khi có lỗi xảy ra
  * */
  void setErrorMessage(dynamic msg) {
    appNavigator.dialog(CustomDialog(description: msg, onConfirm: _onConfirm));
    // ViewUtils.toast(msg, mode: mode);
  }

  /*
  * Luôn sử dụng update để thông báo thay đổi dữ liệu. [update] sẽ an toàn hơn [notifyListeners]
  *
  * Không sử dụng thuần [notifyListeners]
  * */
  void update() {
    if (mounted) notifyListeners();
  }

  void _onConfirm() {
    if (_status == Status.firstIssue) appNavigator.pop();
  }
}
