import 'dart:developer';

import 'package:achitecture_weup/common/core/page_manager/push_page_builder.dart';
import 'package:achitecture_weup/common/core/page_manager/route_path.dart';
import 'package:achitecture_weup/common/core/widget/undefined_layout.dart';
import 'package:achitecture_weup/screen/home/home_page.dart';
import 'package:achitecture_weup/screen/login/login_page.dart';
import 'package:achitecture_weup/screen/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  Widget page;

  switch (settings.name) {
    case RoutePath.INITIAL:
      page = const SplashPage();
      break;
    case RoutePath.LOGIN:
      page = const LoginPage();
      break;
    case RoutePath.HOME:
      page = const HomePage();
      break;
    case RoutePath.STEPPER_FIX:
      page = Container();
      break;
    case RoutePath.INTRODUCE:
      page = const IntroducePage();
      break;
    default:
      page = UndefinedLayout(
        name: settings.name,
      );
      break;
  }
  log('Page: $page | RoutePath: ${settings.name} |Args: ${settings.arguments}', name: 'WEUP-APP');

  return PushPageBuilder.pushPageBuilder(settings, page);
}
