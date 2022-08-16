import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/core/page_manager/route_path.dart';
import 'package:achitecture_weup/common/core/widget/dialog/error_dialog_comp.dart';
import 'package:achitecture_weup/common/helper/constant.dart';
import 'package:flutter/cupertino.dart';

import '../../../state/app_navigator.dart';
import '../../../config/app_config.dart';

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
    appNavigator?.dialog(const BaseErrorDialog(content: HttpConstant.TOKEN_EXPIRED, showCancel: false));
  }
}
