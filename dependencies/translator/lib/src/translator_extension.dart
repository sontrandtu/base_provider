import 'translator.dart';

extension LanguageExtension on String {
  String get tr => translate();

  String translate({List<String>? args}) {
    String? s = Translator().languages[this];
    if (s == null || s.isEmpty) return s = this;
    if (args == null) return s;
    for (var str in args) {
      s = s!.replaceFirst('%s', str);
    }
    return this;
  }
}

class LanguageCode {
  static const String VI = 'vi';
  static const String EN = 'en';
}

class LanguageCountry {
  static const String VI = 'VN';
  static const String EN = 'US';
}

class LanguageLocale {
  static const String VI = 'vi_VN';
  static const String EN = 'en_US';
}
