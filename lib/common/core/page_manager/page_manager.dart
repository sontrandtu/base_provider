import 'package:achitecture_weup/common/core/page_manager/push_page_builder.dart';
import 'package:achitecture_weup/common/core/page_manager/route_path.dart';
import 'package:achitecture_weup/screen/login/login_page.dart';
import 'package:achitecture_weup/screen/splash/splash_page.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

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
