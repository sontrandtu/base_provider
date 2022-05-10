import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/page_manager/app_navigator.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/resource/enum_resource.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  Status _status = Status.loading;

  RouteSettings? _settings;

  // BuildContext? _context;

  AppNavigator? _appNavigator = AppNavigator();

  /// ---------------------------------------------------

  /*
  * [AppNavigator] thực hiện các navigation bên trong ViewModel
  * */
  AppNavigator get appNavigator => _appNavigator!;

  /*
  * Trạng thái của view
  * */
  Status get status => _status;

  // BuildContext get context => _context!;

  /*
  * Route hiện tại
  * */
  String? get currentRoute => _settings?.name;

  @Deprecated('Sử dụng [getConnection({Function? reconnect})] thay vì [isConnecting], '
      'trường này không hỗ trợ thực hiện lại request khi mất kết nối')
  Future<bool> get isConnecting async => await getConnection();

  /// -----------------------------------------------------

  /*
  * Arguments từ page trước
  * */
  dynamic getArguments() => _settings?.arguments;

  /*
  * Hàm được chạy đầu tiên ngay sau khi chuyển page
  * */
  Future<void> initialData() async => await fetchData();

  /*
  * Hàm dùng để call api ngay sau khi [initialData] được
  * sử dụng khi [initialData] có [supper]
  * */
  @mustCallSuper
  Future<void> fetchData() async {
    if (await getConnection(reconnect: fetchData)) return;
  }

  /*
  * Hàm được chạy khi page đã hoàn tất tất cả frame
  *
  * Hàm được recommend thực thi liên quan đến navigation:
  * dialog, push page, buttonsheet,...
  * */
  void onViewCreated() {}

  void setMounted(bool mounted){

  }

  /*
  * Hỗ trợ nhanh delay một khoảng thời gian,
  * thường được sử dụng trong môi trường dev
  * */
  Future<void> delay(int millis) async => await Future.delayed(Duration(milliseconds: millis));

  /*
  * Kiểm tra connect internet, thường được kiểm tra 1 lần trước
  * khi thực hiện các request
  * */
  Future<bool> getConnection({Function? reconnect}) async {
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

  void _setRouteSetting(RouteSettings? rs) => _settings = rs;

  /*
  * Lấy ra context và argument, phục vụ navigation, [getArgument]
  *
  * Không cần đến context trong [ViewModel]
  * */
  void setBuildContext(BuildContext? ctx) {
    // _context = ctx;

    _appNavigator?.setBuildContext(ctx);

    _setRouteSetting(ModalRoute.of(ctx!)?.settings);
  }

  /*
  * Khi thực thi xong một request, [checkNull] nên được gọi
  * để có thể kiểm tra có dữ liệu hay thành công hay không
  * */
  bool checkNull(ApiResponse? value, {bool isInitial = true}) {
    if (value?.data != null) return false;

    setStatus(isInitial ? Status.errorInit : Status.error);

    setErrorMessage(value?.message);

    return true;
  }

  /*
  * Thực hiện show dialog khi có lỗi xảy ra
  * */
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
