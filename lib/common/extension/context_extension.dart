import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/helper/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MessageType { error, success }

extension ContextExtension on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  bool get isTablet {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide >= 600;
  }

  double get paddingTop => MediaQuery.of(this).padding.top;

  TextStyle textStyle({
    Color? color,
  }) {
    return Theme.of(this)
        .textTheme
        .bodyText1!
        .copyWith(fontWeight: FontWeight.normal, color: color);
  }

  Future<void> copyText(
      String text, {
        bool showToast = true,
        VoidCallback? callback,
      }) {

    var data = ClipboardData(text: text);
    return Clipboard.setData(data).then((_) {
      if (showToast) {
        ViewUtils.toast(KeyLanguage.copied.tl + ': ' + text);
      }
      callback?.call();
    }).catchError((_) {});
  }
}

extension NavigatorStateExtension on NavigatorState {
  void pushNamedIfNotCurrent(String routeName, {Object? arguments}) {
    if (!isCurrent(routeName)) {
      pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
