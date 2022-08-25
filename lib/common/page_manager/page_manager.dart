import 'package:achitecture_weup/screen/login/login_page.dart';
import 'package:achitecture_weup/screen/splash/splash_page.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgets/widgets.dart';

import 'route_path.dart';

Map<String, WidgetBuilder> routes = {
  RoutePath.INITIAL: (_) => SplashPage(),
  RoutePath.LOGIN: (_) => LoginPage(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name?.split('?').first;

  showLogState('Page: $routeName | RoutePath: ${settings.name} ');

  return CupertinoPageRoute(
      builder: routes[routeName] ?? (_) => UndefinedLayout(name: settings.name), settings: settings);
}
