import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:achitecture_weup/common/helper/constant.dart';
import 'package:achitecture_weup/common/local_storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeViewModel extends BaseViewModel {
  late ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeViewModel() {
    _mode = getInitMode;
  }

  Future<void> toggleMode() async {
    _mode = getThemeMode;

    appStyle = getThemeData;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: getBrightness));

    String saveTheme = isLightMode ? ThemeModeConstant.LIGHT : ThemeModeConstant.DARK;

    await HiveStorage.putValue(HiveKey.themeKey, saveTheme);

    notifyListeners();
  }

  bool get isLightMode => _mode == ThemeMode.light;

  ThemeMode get getThemeMode => isLightMode ? ThemeMode.dark : ThemeMode.light;

  ThemeMode get getInitMode =>
      HiveStorage.getValue(HiveKey.themeKey, defaultValue: ThemeModeConstant.LIGHT) == ThemeModeConstant.LIGHT
          ? ThemeMode.light
          : ThemeMode.dark;

  ThemeData get getThemeData =>
      isLightMode ? ThemeManager.instance.lightTheme : ThemeManager.instance.darkTheme;

  Brightness get getBrightness => isLightMode ? Brightness.dark : Brightness.light;
}
