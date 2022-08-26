import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:achitecture_weup/common/resource/color/dark_color.dart';
import 'package:achitecture_weup/common/theme/theme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<ThemeModel> mThemes = [
  ThemeModel(
    id: 0,
    color: BaseColor(),
    data: ThemeData(
      appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
      fontFamily: 'Babylon',
      textTheme: TextTheme(
        headline6: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        headline5: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        headline3: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        headline2: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        headline1: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        bodyText2: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),
    ),
  ),
  ThemeModel(
    id: 1,
    color: DarkColor(),
    data: ThemeData(
      appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
      fontFamily: 'Babylon',
      textTheme: const TextTheme(
        headline6: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
        headline5: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
        headline4: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
        headline3: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
        headline2: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),
        headline1: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),
        bodyText1: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),
        bodyText2: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
      ),
    ),
  )
];
