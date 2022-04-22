import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/common/helper/app_common.dart';
import 'package:achitech_weup/common/helper/constant.dart';
import 'package:flutter/cupertino.dart';

class HomeViewModel extends BaseViewModel {
  String? language;

  @override
  Future<void> initialData() async {
    language = ViewUtils.getLocale()?.languageCode;
  }

  Future<void> changLanguage() async {
    if (ViewUtils.getLocale()?.languageCode == LanguageCodeConstant.VI) {
      ViewUtils.changeLanguage(const Locale(LanguageCodeConstant.EN, LanguageCountryConstant.EN));
      setLanguage();
      return;
    }
    ViewUtils.changeLanguage(const Locale(LanguageCodeConstant.VI, LanguageCountryConstant.VI));
    setLanguage();
  }

  void setLanguage() {
    language = ViewUtils.getLocale()?.languageCode;
    notifyListeners();
  }
}
