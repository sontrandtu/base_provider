import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/state/base_view_model.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/resource/enum_resource.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends BaseViewModel {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool currentLanguage = false;
  String args = '';

  @override
  Future<void> initialData() async {
    fetchData();
    setStatus(Status.success);
  }

  @override
  Future<void> fetchData() async {
  }

  void login() async {
    // await NewRepository.instance.getAllPost();
    setStatus(Status.waiting);
    // await delay(1000);
    // if (await getConnection(reconnect: login)) return;
    //
    // ApiResponse<List<Post>> response = await compute(NewRepository.instance.getAllPost,<String,dynamic>{});
    //
    // if (checkNull(response,isInitial: false)) return;

    setStatus(Status.success);

    // appNavigator.pushNamed(RoutePath.HOME, arguments: {'dynamic argument': 'OK'},params: {'data':'String'});
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

  changeSwitch(bool value) {
    currentLanguage = value;
    update();

  }

  clearCache() {

  }
}
