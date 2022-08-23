import 'package:state/state.dart';
import 'package:widgets/widgets.dart';

import '../config/app_config.dart';
import '../page_manager/route_path.dart';


class HandleHttpException {
  int? code;
  AppNavigator? appNavigator;
  Function? util;

  HandleHttpException({this.code, this.appNavigator, this.util});

  void catchError() {
    switch (code) {
      case -3:
        _tokenExpired();
        break;
    }
  }

  void _tokenExpired() {
    AppConfig().unAuthenticate();
    appNavigator?.pop();
    appNavigator?.pushNamedAndRemoveUntil(RoutePath.LOGIN);
    appNavigator?.popUntil(RoutePath.LOGIN);
    appNavigator?.dialog(const CustomDialog(description: 'HttpConstant.TOKEN_EXPIRED', title: 'Thông báo'));
  }
}
