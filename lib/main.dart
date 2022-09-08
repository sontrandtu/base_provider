import 'dart:io';

import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';
import 'package:translator/translator.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await LocalStorage.ensureInitialized();
  await DataConfig.ensureInitialized();
  Translator().initialize();
  ThemeManager().init();

  runApp(const Application());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
