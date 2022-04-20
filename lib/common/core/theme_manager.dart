import 'package:achitech_weup/common/app_common.dart';
import 'package:achitech_weup/common/resource/color_resource.dart';
import 'package:flutter/material.dart';

ThemeData appStyle = ThemeManager.instance.themeData;

class ThemeManager {
  ThemeManager._internal();

  static ThemeManager get instance => ThemeManager._internal();

  ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    // màu chữ mặc định
    primaryColor: ColorResource.primary,
    primaryColorDark: ColorResource.primary,
    primaryColorLight: ColorResource.primary,
    cardColor: Colors.white,
    indicatorColor: ColorResource.primary,
    //canvasColor: Colors.yellow,
    dividerColor: Colors.blueGrey,
    toggleableActiveColor: ColorResource.primary,

    fontFamily: 'Babylon',
    textTheme: const TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 14),
      headline5: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 16),
      headline4: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 18),
      headline3: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 20),
      headline2: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 22),
      headline1: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 24),
      bodyText1: TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 16),
      bodyText2: TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 14),
    ),
  );
}
