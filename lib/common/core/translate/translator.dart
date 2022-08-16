import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../application.dart';
import '../../local_storage/local_storage.dart';
import '../sys/base_function.dart';
import 'en.dart';
import 'translator_extension.dart';
import 'vi.dart';

class Translator {
  Translator._internal();

  static final Translator _translator = Translator._internal();

  factory Translator() => _translator;

  static Translator? of(BuildContext context) => Localizations.of<Translator>(context, Translator);

  static const LocalizationsDelegate<Translator> delegate = _ApplicationLocalizationsDelegate();

  Locale? currentLocale;

  String? currentLanguageCode;

  Locale defaultLocale = const Locale(LanguageCode.VI, LanguageCountry.VI);

  Map<String, dynamic> languages = {};

  void initialize() {
    String languageCode = LocalStorage.get(StorageKey.LANGUAGE, '');
    if (languageCode.isEmpty) languageCode = Intl.shortLocale(Platform.localeName);
    setCurrentLocale(languageCode);
  }

  Future<void> changeLanguage(String languageCode) async {
    setCurrentLocale(languageCode);

    showLog('Locale: $currentLocale');

    languages = en;
    if (languageCode == LanguageCode.VI) languages = vi;

    currentLanguageCode = languageCode;

    await LocalStorage.put(StorageKey.LANGUAGE, languageCode);

    Application.updateLanguage();
  }

  void setCurrentLocale(String languageCode) {
    currentLocale =
        supports.singleWhereOrNull((element) => element.languageCode == languageCode) ?? defaultLocale;
  }

  List<Locale> supports = [
    const Locale(LanguageCode.VI, LanguageCountry.VI),
    const Locale(LanguageCode.EN, LanguageCountry.EN)
  ];
}

class _ApplicationLocalizationsDelegate extends LocalizationsDelegate<Translator> {
  const _ApplicationLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return Translator().supports.map((e) => e.languageCode).contains(locale.languageCode);
  }

  @override
  Future<Translator> load(Locale locale) async {
    // await Translator().changeLanguage(locale.languageCode);
    await Translator().changeLanguage(LanguageCode.VI);
    return Translator();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translator> old) => false;
}
