import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewUtils {
  static void hideKeyboard({BuildContext? context}) => FocusScope.of(context!).unfocus();

  static Widget divider() => Container(color: ColorResource.divider, height: 1);

  static Widget verticalDivider({double? h}) =>
      Container(color: ColorResource.divider, width: 1, height: h ?? 15);

  static Future<void>? changeLanguage(Locale locale, {BuildContext? context}) =>
      navigator.currentContext?.setLocale(locale);

  static Locale? getLocale({BuildContext? context}) => navigator.currentContext?.locale;

  static double get width => MediaQuery.of(navigator.currentContext!).size.width;

  static double get height => MediaQuery.of(navigator.currentContext!).size.height;

  static double get heightAppBar => 24;

  static void toast(dynamic msg) => Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: ColorResource.primary,
      textColor: ColorResource.textBody,
      fontSize: 16.0);
}
