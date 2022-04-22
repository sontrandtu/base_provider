import 'package:achitech_weup/application.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ViewUtils {
  static void hideKeyboard({BuildContext? context}) => FocusScope.of(context!).unfocus();

  static Widget divider() => Container(color: ColorResource.divider, height: 1);

  static Widget verticalDivider({double? h}) =>
      Container(color: ColorResource.divider, width: 1, height: h ?? 15);

  static Future<void>? changeLanguage(Locale locale, {BuildContext? context}) =>
      navigator.currentContext?.setLocale(locale);

  static Locale? getLocale({BuildContext? context}) => navigator.currentContext?.locale;
}
