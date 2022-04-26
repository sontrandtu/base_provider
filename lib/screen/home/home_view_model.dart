import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  String? language;
  bool _valueSwitch = false;

  String radioValue1 = 'a';
  String radioValue2 = 'b';
  String radioValue3 = 'c';
  String radioValue4 = 'd';
  String groupRadio = 'e';

  get valueSwitch => _valueSwitch;

  @override
  Future<void> initialData() async {
    language = ViewUtils.getLocale()?.languageCode;
  }

  Future<void> changLanguage() async {
    if (ViewUtils.getLocale()?.languageCode == LanguageCodeConstant.VI) {
      ViewUtils.changeLanguage(
          const Locale(LanguageCodeConstant.EN, LanguageCountryConstant.EN));
      setLanguage();
      return;
    }
    ViewUtils.changeLanguage(
        const Locale(LanguageCodeConstant.VI, LanguageCountryConstant.VI));
    setLanguage();
  }

  void setLanguage() {
    language = ViewUtils.getLocale()?.languageCode;
    notifyListeners();
  }

  void changeSwitch(bool? value) {
    _valueSwitch = value ?? false;
    notifyListeners();
  }

  void changeRadio(String? value)  {
    groupRadio = value ?? 'c';
    update();
  }
}
