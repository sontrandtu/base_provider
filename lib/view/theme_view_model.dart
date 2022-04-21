import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/common/local_storage/app_storage.dart';
import 'package:flutter/material.dart';

class ThemeViewModel extends BaseViewModel {
  late ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeViewModel() {
    _mode = HiveStorage.getValue(HiveKey.themeKey, 'light') == 'light'
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  Future<void> toggleMode() async {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    String saveTheme = _mode == ThemeMode.light ? ' light' : 'dark';
    await HiveStorage.putValue(HiveKey.themeKey, saveTheme);
    notifyListeners();
  }
}
