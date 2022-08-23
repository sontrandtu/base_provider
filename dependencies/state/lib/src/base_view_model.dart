import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state/src/status.dart';

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
  * Route hiện tại
  * */
  String? get currentRoute => settings?.name?.split('?').firstOrNull;

  /*
  * Route kèm parameter
  * */
  String? get originalRoute => settings?.name;

  /*
  * Arguments từ page trước
  * */
  dynamic getArguments() => settings?.arguments;

  /*
  * Parameter từ page trước
  * */
  Map<String, dynamic>? getParameter() => Uri.tryParse(originalRoute ?? '')?.queryParameters;

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
    if (value.code == 200) return false;

    // HandleHttpException(code: value.err?.code, appNavigator: appNavigator).catchError();

    // if (value.err?.code == CodeConstant.INVALID_SIGN) return true;

    if (flagLifecycle == Lifecycle.INIT) setStatus(Status.firstIssue);

    if (flagLifecycle == Lifecycle.BUILD) setStatus(Status.error);

    if (!isShowDialog) return true;

    setErrorMessage(value.message.tl);

    return true;
  }

  /*
  * Thực hiện show dialog khi có lỗi xảy ra
  * */
  void setErrorMessage(dynamic msg) {
    // appNavigator.dialog(BaseErrorDialog(
    //   content: msg,
    //   showCancel: false,
    //   mConfirm: _onConfirm,
    // ));
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
    if (_status == Status.firstIssue) {
      appNavigator.pop();
      // appNavigator.pop();
    }
  }
}
