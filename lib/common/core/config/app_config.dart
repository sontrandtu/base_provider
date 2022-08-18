import 'package:achitecture_weup/common/core/config/app_config_base.dart';
import 'package:flutter/services.dart';

class AppConfig extends AppConfigBase {
  factory AppConfig() => _i;

  static final AppConfig _i = AppConfig._internal();

  AppConfig._internal();

  @override
  Future<void> authenticate() async {

  }

  @override
  Future<void> unAuthenticate() async {

  }

  @override
  void setOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}