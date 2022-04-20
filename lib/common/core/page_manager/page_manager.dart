import 'dart:developer';

import 'package:achitech_weup/common/core/page_manager/key_page.dart';
import 'package:achitech_weup/common/core/widget/undefined_layout.dart';
import 'package:achitech_weup/view/home_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  log('-->generateRoute: ${settings.name} | ${settings.arguments}', name: 'WEUP-APP');
  Widget page;

  switch (settings.name) {
    case KeyPage.initial:
      page = Container();
      break;
      case KeyPage.home:
      page = HomePage();
      break;
    default:
      page = UndefinedLayout(name: settings.name);
      break;
  }

  log('-->> push page: $page', name: 'WEUP-APP');
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
