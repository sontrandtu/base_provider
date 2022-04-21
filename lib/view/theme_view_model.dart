import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeViewModel({
    ThemeMode mode = ThemeMode.light,
  }) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
