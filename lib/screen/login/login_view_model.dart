import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/common/extension/string_extension.dart';
import 'package:achitech_weup/common/resource/enum_resource.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends BaseViewModel {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Future<void> initialData() async {
    setStatus(Status.success);
  }

  void login() async {
    setStatus(Status.loading);
    await delay(2000);
    appNavigator.pushReplacementNamed(RoutePath.HOME);
    setStatus(Status.success);
  }

  void register() {
    appNavigator.dialog(const BaseErrorDialog(content: 'Cảm ơn bạn đã chọn đăng ký', showCancel: false));
  }

  String? validator(String s, index) {
    switch (index) {
      case 0:
        if (s.isEmpty) return 'Vui lòng nhập tên tài khoản';
        if (!s.isValidEmail) return 'Email không đúng định dạng';
        break;
      case 1:
        if (s.isEmpty) return 'Vui lòng nhập mật khẩu';
        if (s.length < 6) return 'Mật khẩu tối thiểu 5 ký tự';
    }
    return null;
  }
}
