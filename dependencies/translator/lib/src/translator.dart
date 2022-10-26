import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:storage/storage.dart';

import 'en.dart';
import 'translator_extension.dart';
import 'vi.dart';


class Translator {
  Translator._internal();

  static final Translator _translator = Translator._internal();

  factory Translator() => _translator;

  Timer? _timer;


  Locale? currentLocale;

  Locale defaultLocale = const Locale(LanguageCode.VI, LanguageCountry.VI);

  Map<String, dynamic> languages = {};

  void initialize() {

    String languageCode = LocalStorage.get(StorageKey.LANGUAGE, '');

    if (languageCode.isEmpty) {
      languageCode = kIsWeb ? defaultLocale.languageCode : Intl.shortLocale(Platform.localeName);
    }
    setCurrentLocale(languageCode);
  }

  void load(String languageCode) {
    languages = en;
    if (languageCode == LanguageCode.VI) languages = vi;

    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: 500), () => LocalStorage.put(StorageKey.LANGUAGE, languageCode));
  }

  void setCurrentLocale(String languageCode) {
    load(languageCode);

    currentLocale =
        supports.singleWhereOrNull((element) => element.languageCode == languageCode) ?? defaultLocale;
    WidgetsBinding.instance.performReassemble();
  }

  List<Locale> supports = [
    const Locale(LanguageCode.VI, LanguageCountry.VI),
    const Locale(LanguageCode.EN, LanguageCountry.EN)
  ];
}

class ApplicationLocalizationsDelegate extends LocalizationsDelegate<Translator> {
  @override
  bool isSupported(Locale locale) =>
      Translator().supports.map((e) => e.languageCode).contains(locale.languageCode);

  @override
  Future<Translator> load(Locale locale) async => Translator();

  @override
  bool shouldReload(LocalizationsDelegate<Translator> old) => false;
}
