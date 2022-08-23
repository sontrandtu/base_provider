import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appStyle = Theme.of(Application.navigator.currentContext!);

class ThemeManager {
  ThemeManager._internal();

  static final ThemeManager _instance = ThemeManager._internal();

  factory ThemeManager()=> _instance;

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
    ),
    primaryColor: ColorResource.primary,
    indicatorColor: ColorResource.primary,
    backgroundColor: Colors.white,
    dividerColor: Colors.blueGrey,
    toggleableActiveColor: ColorResource.primary,
    splashColor: ColorResource.colorSplash,
    highlightColor: ColorResource.colorHighLight,
    primarySwatch: ColorResource.primarySwatchMaterial,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Babylon',
    textTheme: const TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 14),
      headline5: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 16),
      headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      headline3: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 20),
      headline2: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 22),
      headline1: TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 24),
      bodyText1: TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 16),
      bodyText2: TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 14),
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorResource.primary,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
    ),
    indicatorColor: ColorResource.primary,
    dividerColor: Colors.blueGrey,
    toggleableActiveColor: ColorResource.primary,
    splashColor: ColorResource.colorSplash,
    highlightColor: ColorResource.colorHighLight,
    primarySwatch: ColorResource.primarySwatchMaterial,
    cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          inherit: false,
          fontFamily: 'Babylon',
          fontSize: 21.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.6,
          color: CupertinoColors.label,
        ),
        dateTimePickerTextStyle: TextStyle(
          inherit: false,
          fontFamily: 'Babylon',
          fontSize: 21,
          fontWeight: FontWeight.normal,
          color: CupertinoColors.label,
        ),
      ),
    ),

    scaffoldBackgroundColor: Colors.grey[850],
    fontFamily: 'Babylon',
    textTheme: const TextTheme(
      headline6: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      headline5: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      headline3: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
      headline2: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      headline1: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
      bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      bodyText2: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    ),
  );
}
