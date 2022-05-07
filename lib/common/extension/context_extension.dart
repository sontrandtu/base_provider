import 'package:flutter/material.dart';

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
