import 'dart:async';
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
  await DataConfig().initializedDB(path: '/storage/');
  Translator().initialize();
  ThemeManager().init();

  FlutterError.onError = onError;

  runZonedGuarded(() => runApp(const Application()), onZoneError);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void onError(FlutterErrorDetails details) {
  print(' FlutterError.onError');
  print(details);
}

void onZoneError(Object error, StackTrace stack) {
  print(' onZoneError');
  print(error);
}
