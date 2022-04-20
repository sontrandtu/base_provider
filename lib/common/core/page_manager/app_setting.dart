import 'package:flutter/cupertino.dart';

class AppSetting{
  static RouteSettings? settings;

  static dynamic get arguments => settings?.arguments;
  static dynamic get routePath => settings?.name;
}