import 'package:achitech_weup/application.dart';
import 'package:achitech_weup/common/resource/color_resource.dart';
import 'package:flutter/material.dart';

ThemeData appStyle = Theme.of(navigator.currentContext!);

class ThemeManager {
  ThemeManager._internal();

  static ThemeManager get instance => ThemeManager._internal();

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorResource.primary,
    indicatorColor: ColorResource.primary,
    dialogBackgroundColor: Colors.white,
    dividerColor: Colors.blueGrey,
    toggleableActiveColor: ColorResource.primary,
    splashColor: ColorResource.colorSplash,
    highlightColor: ColorResource.colorHighLight,
    primarySwatch: ColorResource.primarySwatchMaterial,
    fontFamily: 'Babylon',
    textTheme: const TextTheme(
      headline6: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 14),
      headline5: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 16),
      headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      headline3: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 20),
      headline2: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 22),
      headline1: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 24),
      bodyText1: TextStyle(
          fontWeight: FontWeight.w400,
          color: ColorResource.textBody,
          fontSize: 16),
      bodyText2: TextStyle(
          fontWeight: FontWeight.w400, color: Colors.red, fontSize: 14),
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorResource.primary,
    indicatorColor: ColorResource.primary,
    dividerColor: Colors.blueGrey,
    toggleableActiveColor: ColorResource.primary,
    splashColor: ColorResource.colorSplash,
    highlightColor: ColorResource.colorHighLight,
    primarySwatch: ColorResource.primarySwatchMaterial,
    fontFamily: 'Babylon',
    textTheme: const TextTheme(
      headline6: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 14),
      headline5: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 16),
      headline4: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 18),
      headline3: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 20),
      headline2: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 22),
      headline1: TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorResource.textBody,
          fontSize: 24),
      bodyText1: TextStyle(
          fontWeight: FontWeight.w400,
          color: ColorResource.textBody,
          fontSize: 16),
      bodyText2: TextStyle(
          fontWeight: FontWeight.w400,
          color: ColorResource.textBody,
          fontSize: 14),
    ),
  );
}
