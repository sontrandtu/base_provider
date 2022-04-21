import 'dart:io';

import 'package:achitech_weup/application.dart';
import 'package:achitech_weup/common/local_storage/app_storage.dart';
import 'package:achitech_weup/screen/login/login_view_model.dart';
import 'package:achitech_weup/screen/splash/splash_view_model.dart';
import 'package:achitech_weup/view/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final SplashViewModel splashViewModel = SplashViewModel();
final LoginViewModel loginViewModel = LoginViewModel();
final ThemeViewModel themeViewModel = ThemeViewModel();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
 await HiveStorage.install();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: splashViewModel),
        ChangeNotifierProvider.value(value: loginViewModel),
        ChangeNotifierProvider.value(value: themeViewModel),
      ],
      child: const Application(),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
