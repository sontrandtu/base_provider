import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/screen/login/login_view_model.dart';
import 'package:achitecture_weup/screen/splash/splash_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'application.dart';
import 'common/core/theme/theme_view_model.dart';
import 'common/local_storage/hive_storage.dart';
import 'common/module/firebase_module.dart';

final SplashViewModel splashViewModel = SplashViewModel();
final LoginViewModel loginViewModel = LoginViewModel();
final ThemeViewModel themeViewModel = ThemeViewModel();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await _installFirebase();
  HttpOverrides.global = MyHttpOverrides();
 await HiveStorage.install();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: splashViewModel),
        ChangeNotifierProvider.value(value: loginViewModel),
        ChangeNotifierProvider.value(value: themeViewModel),
      ],
      child: EasyLocalization(
        fallbackLocale: const Locale('vi', 'VN'),
        startLocale: const Locale('vi', 'VN'),
        useOnlyLangCode: true,
        saveLocale: true,
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        child: const Application(),
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent,statusBarBrightness: Brightness.light));
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
