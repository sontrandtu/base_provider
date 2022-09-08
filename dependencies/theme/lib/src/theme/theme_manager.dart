import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:storage/storage.dart';

import '../base_color.dart';
import 'theme_model.dart';

BaseColor ColorResource = BaseColor();

typedef OnUpdate = void Function();

class ThemeManager {
  ThemeManager._internal();

  static final ThemeManager _instance = ThemeManager._internal();

  factory ThemeManager() => _instance;

  ThemeModel? _themeModel;

  OnUpdate? _onUpdate;

  ThemeData? get value => _themeModel?.data;

  int get themeId => _themeModel?.id ?? -1;

  bool isDarkMode() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    return brightness == Brightness.dark;
  }

  void init({OnUpdate? onUpdate}) {
    _onUpdate = onUpdate;

    int? themeId = LocalStorage.get<int>(StorageKey.THEME);

    if (themeId != null) return setThemeById(themeId);

    if (isDarkMode()) return setThemeById(1);

    setThemeById(0);
  }

  void setThemeById(int id) async {
    _themeModel = _mThemes.singleWhere((element) => element.id == id);

    if (_themeModel?.color != null) ColorResource = _themeModel!.color!;

    _onUpdate?.call();

    await LocalStorage.put(StorageKey.THEME, id);
  }

  List<ThemeModel> _mThemes = [
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
    )
  ];
}
