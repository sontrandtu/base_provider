import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:achitecture_weup/common/resource/color/dark_color.dart';
import 'package:achitecture_weup/common/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:storage/storage.dart';

ThemeData appStyle = Theme.of(Application.navigator.currentContext!);

class ThemeManager {
  ThemeManager._internal();

  static final ThemeManager _instance = ThemeManager._internal();

  factory ThemeManager() => _instance;

  ThemeModel? _themeModel;

  ThemeData? get value => _themeModel?.data;

  int get themeId => _themeModel?.id ?? -1;

  bool isDarkMode() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  void init() {
    int? themeId = LocalStorage.get<int>(StorageKey.THEME);

    if (themeId != null) return setThemeById(themeId);

    if (isDarkMode()) return setThemeById(1);

    setThemeById(0);
  }

  void setThemeById(int id) async {
    _themeModel = mThemes.singleWhere((element) => element.id == id);

    if (_themeModel?.color != null) ColorResource = _themeModel!.color!;

    WidgetsBinding.instance.performReassemble();

    await LocalStorage.put(StorageKey.THEME, id);
  }

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
          button: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
    )
  ];
}
