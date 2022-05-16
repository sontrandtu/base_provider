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
    _mode = initMode();
    setUiOverlay();
  }

  Future<void> toggleMode() async {
    _changMode();

    String saveTheme = _mode == ThemeMode.light ? ThemeModeConstant.LIGHT : ThemeModeConstant.DARK;

    await LocalStorage.put(StorageKey.THEME, saveTheme);

    _changeThemeData();

    setUiOverlay();


    notifyListeners();
  }

  bool get isLightMode =>
      LocalStorage.get(StorageKey.THEME, ThemeModeConstant.LIGHT) == ThemeModeConstant.LIGHT;

  ThemeMode initMode() => _mode = isLightMode ? ThemeMode.light : ThemeMode.dark;

  Brightness get brightness => _mode == ThemeMode.light ? Brightness.dark : Brightness.light;

  void setUiOverlay() => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: brightness));

  void _changMode() => _mode = isLightMode ? ThemeMode.dark : ThemeMode.light;

  void _changeThemeData() =>
      appStyle = isLightMode ? ThemeManager.instance.lightTheme : ThemeManager.instance.darkTheme;
}
