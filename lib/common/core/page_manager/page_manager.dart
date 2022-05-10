import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/page_manager/push_page_builder.dart';
import 'package:achitecture_weup/screen/home/home_page.dart';
import 'package:achitecture_weup/screen/list_todo/list_todo_page.dart';
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
    case RoutePath.TODO_LIST:
      page = const ListTodoPage();
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
