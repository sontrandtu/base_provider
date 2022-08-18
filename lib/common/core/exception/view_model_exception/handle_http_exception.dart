import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/core/config/app_config.dart';
import 'package:achitecture_weup/common/core/page_manager/route_path.dart';
import 'package:achitecture_weup/common/helper/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:state/state.dart';
import 'package:widgets/widgets.dart';


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
    Navigator.pop(Application.navigator.currentContext!);
    appNavigator?.pushNamedAndRemoveUntil(RoutePath.LOGIN);
    appNavigator?.popUntil(RoutePath.LOGIN);
    appNavigator?.dialog(const CustomDialog(description: HttpConstant.TOKEN_EXPIRED, title: 'Thông báo'));
  }
}
