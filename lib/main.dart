import 'dart:io';

import 'package:flutter/material.dart';
import 'package:request_cache_manager/request_cache_manager.dart';
import 'package:storage/storage.dart';
import 'package:translator/translator.dart';

import 'application.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await LocalStorage.ensureInitialized();
  Translator().initialize();
  await CacheStorage.ensureInitialized();

  runApp( const Application());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
