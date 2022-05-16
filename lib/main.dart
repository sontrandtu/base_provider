import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'application.dart';
import 'common/core/theme/theme_view_model.dart';
import 'common/local_storage/local_storage.dart';
import 'common/module/firebase_module.dart';
ThemeViewModel themeViewModel = ThemeViewModel();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await LocalStorage.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await _installFirebase();



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeViewModel),
      ],
      child: EasyLocalization(
        fallbackLocale: const Locale('vi', 'VN'),
        startLocale: const Locale('vi', 'VN'),
        useOnlyLangCode: true,
        logEnable: false,
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        child: const Application(),
      ),
    ),
  );
}

Future<void> _installFirebase() async {
  await FirebaseModule.instance.installSDK();
  FirebaseModule.instance.interface = FirebaseInterface();

  FirebaseModule.instance.initialMessage();
  FirebaseModule.instance.pushNotification();
  FirebaseModule.instance.pushNotificationOpenedApp();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
