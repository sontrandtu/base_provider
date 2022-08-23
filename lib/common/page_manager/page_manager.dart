import 'package:achitecture_weup/screen/login/login_page.dart';
import 'package:achitecture_weup/screen/splash/splash_page.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'push_page_builder.dart';
import 'route_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  Widget page;
  String? routeName = settings.name?.split('?').first;

  switch (routeName) {
    case RoutePath.INITIAL:
      page = const SplashPage();
      break;
    case RoutePath.LOGIN:
      page = const LoginPage();
      break;

    case RoutePath.TODO_LIST:
      page = Container();
      break;

    default:
      page = UndefinedLayout(
        name: settings.name,
      );
      break;
  }
  showLogState('Page: $page | RoutePath: ${settings.name} ');

  return PushPageBuilder.pushCupertinoPageBuilder(settings, page);
}
