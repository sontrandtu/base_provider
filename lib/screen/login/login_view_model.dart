import 'package:domain/domain.dart';
import 'package:state/src/nav_obs.dart';
import 'package:achitecture_weup/common/page_manager/route_path.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:state/state.dart';
import 'package:widgets/widgets.dart';

class LoginViewModel extends BaseViewModel {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool currentLanguage = false;
  String args = '';

  @override
  Future<void> init() async {
    showError(AppRouting.arguments);
  }

  @override
  Future<void> initialData() async {
    throw ValidateException("lỗi");
    fetchData();
    setStatus(Status.success);
  }

  @override
  Future<void> fetchData() async {}

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

    appNavigator.pushNamed(RoutePath.HOME, arguments: {'dynamic argument': 'OK'});
  }

  void register() {
    showError(AppRouting.arguments);
    // appNavigator.dialog(const CustomDialog(description: 'Cảm ơn bạn đã chọn đăng ký', title: 'Thông báo'));
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

  clearCache() {}
}
