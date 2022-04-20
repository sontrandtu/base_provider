import 'dart:developer';

import 'package:achitech_weup/common/core/page_manager/app_setting.dart';
import 'package:achitech_weup/common/core/page_manager/route_path.dart';
import 'package:achitech_weup/common/core/widget/undefined_layout.dart';
import 'package:achitech_weup/screen/login/login_page.dart';
import 'package:achitech_weup/screen/splash/splash_page.dart';
import 'package:achitech_weup/view/home_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  Widget page;

  switch (settings.name) {
    case RoutePath.initial:
      page = const SplashPage();
      break;
    case RoutePath.login:
      page = const LoginPage();
      break;
    case RoutePath.home:
      page = const HomePage();
      break;
    default:
      page = const UndefinedLayout();
      break;
  }

  AppSetting.settings = settings;
  log('Page: $page | RoutePath: ${settings.name} |Args: ${settings.arguments}',
      name: 'WEUP-APP');

  return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
