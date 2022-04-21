import 'dart:io';

import 'package:achitech_weup/application.dart';
import 'package:achitech_weup/common/local_storage/app_storage.dart';
import 'package:achitech_weup/screen/login/login_view_model.dart';
import 'package:achitech_weup/screen/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
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
