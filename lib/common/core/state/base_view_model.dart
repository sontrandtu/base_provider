import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/resource/enum_resource.dart';

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

  Future<bool> get isConnecting async => await getConnection();

  /*
  * Kiểm tra connect internet, thường được kiểm tra 1 lần trước
  * khi thực hiện các request
  * */
  Future<bool> getConnection({Function()? reconnect}) async {
    if (kIsWeb) return false;
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      appNavigator.dialog(BaseErrorDialog(
        content: HttpConstant.CONNECT_ERROR,
        textButtonConfirm: 'Thử lại',
        mConfirm: () {
          setStatus(Status.loading);
          reconnect ?? appNavigator.back();
        },
        mCancel: appNavigator.back,
      ));

      setStatus(Status.error);

      return true;
    }
  }

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

  bool checkStatus(ApiResponse value, {bool isShowDialog = true}) {
    if (/*value.err?.code == CodeConstant.OK*/ false) return false;

    // HandleHttpException(code: value.err?.code, appNavigator: appNavigator).catchError();

    // if (value.err?.code == CodeConstant.INVALID_SIGN) return true;

    if (flagLifecycle == Lifecycle.INIT) setStatus(Status.firstIssue);

    if (flagLifecycle == Lifecycle.BUILD) setStatus(Status.error);

    if (!isShowDialog) return true;

    // setErrorMessage(value.err?.message.tl, ToastMode.error);

    return true;
  }

  bool isNull(dynamic value, {bool isInitial = true}) {
    if (value == null) {
      setStatus(Status.success);
    }
    return value == null;
  }

  bool isEmpty(dynamic value) {
    if (value is List) {
      return value.isEmpty;
    } else {
      return value == '';
    }
  }

  bool isNullOrEmpty(dynamic data) {
    if (isNull(data) || isEmpty(data)) {
      setStatus(Status.success);
    }
    return isNull(data) || isEmpty(data);
  }

  /*
  * Thực hiện show dialog khi có lỗi xảy ra
  * */
  void setErrorMessage(dynamic msg, [ToastMode mode = ToastMode.error]) {
    appNavigator.dialog(BaseErrorDialog(
      content: msg,
      showCancel: false,
      mConfirm: _onConfirm,
    ));
    ViewUtils.toast(msg, mode: mode);
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
