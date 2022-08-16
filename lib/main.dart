import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'application.dart';
import 'common/core/theme/theme_view_model.dart';
import 'common/local_storage/local_storage.dart';
ThemeViewModel themeViewModel = ThemeViewModel();

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await LocalStorage.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeViewModel),
      ],
      child:const Application(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
