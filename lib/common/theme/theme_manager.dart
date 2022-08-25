import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:achitecture_weup/common/theme/extenal_theme.dart';
import 'package:achitecture_weup/common/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
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

    Application.update();

    await LocalStorage.put(StorageKey.THEME, id);
  }
}
