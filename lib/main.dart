import 'dart:io';

import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_cache_manager/request_cache_manager.dart';
import 'package:storage/storage.dart';

import 'application.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await LocalStorage.ensureInitialized();
  await CacheStorage.ensureInitialized();


  runApp(
    const Application(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
