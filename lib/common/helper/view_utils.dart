import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastMode {
  none,
  success,
  error,
}

class ViewUtils {
  static void hideKeyboard({BuildContext? context}) =>
      FocusScope.of(context!).unfocus();

  static Widget divider() => Container(color: ColorResource.divider, height: 1);

  static Widget verticalDivider({double? h}) =>
      Container(color: ColorResource.divider, width: 1, height: h ?? 15);


  static double get width =>
      MediaQuery.of(Application.navigator.currentContext!).size.width;

  static double get height =>
      MediaQuery.of(Application.navigator.currentContext!).size.height;

  static double get heightStatusBar =>
      MediaQuery.of(Application.navigator.currentContext!).padding.top;

  static void toast(String msg, {ToastMode mode = ToastMode.none, double fontSize = 16.0}) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: _getToastColor(mode),
        textColor: ColorResource.textBody,
        fontSize: fontSize,
      );

  static Color _getToastColor(ToastMode mode) {
    switch(mode) {
      case ToastMode.success:
        return Colors.green;
      case ToastMode.error:
        return Colors.red;
      default:
        return ColorResource.primary;
    }
  }
}
