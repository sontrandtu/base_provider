import 'dart:developer';

import 'package:flutter/material.dart';

/*
* Thực hiện các navigation không cần context
*
* */
class AppNavigator {
  late BuildContext context;

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  void setBuildContext(BuildContext? ctx) => context = ctx!;

  /*
  * Hiển thị dialog
  * */
  Future<dynamic> dialog(Widget dialog, {dynamic arguments, bool? barrierDismissible}) async {
    log('OPEN DIALOG ${dialog.runtimeType} ${dialog.hashCode}', name: 'WEUP-APP');
    return await showDialog(
        context: context,
        builder: (context) => dialog,
        barrierDismissible: barrierDismissible ?? false,
        routeSettings: RouteSettings(arguments: arguments));
  }

  /*
  * Hiển thị bottomSheet
  * */
  Future<dynamic> bottomSheetDialog(Widget dialog, {dynamic arguments}) async => await showModalBottomSheet(
      context: context, builder: (context) => dialog, routeSettings: RouteSettings(arguments: arguments));

  /*
  * Navigate to new page with [RouteName]
  * */
  Future<dynamic> pushNamed(
    String routeName, {
    Map<String, dynamic>? params,
    dynamic arguments,
  }) async {
    if (params != null) {
      final uri = Uri(path: routeName, queryParameters: params);
      routeName = uri.toString();
    }
    await Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /*
  * Navigate to new page with [RouteName] and replace [current page]
  * */
  Future<dynamic> pushReplacementNamed(
    String routeName, {
    Map<String, dynamic>? params,
    dynamic arguments,
    dynamic result,
  }) async {
    if (params != null) {
      final uri = Uri(path: routeName, queryParameters: params);
      routeName = uri.toString();
    }
    await Navigator.pushReplacementNamed(context, routeName, arguments: arguments, result: result);
  }

  /*
  * Navigate to new page with [RouteName] and replace all util pages
  * */
  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Map<String, dynamic>? params,
    dynamic arguments,
  }) async {
    if (params != null) {
      final uri = Uri(path: routeName, queryParameters: params);
      routeName = uri.toString();
    }
    await Navigator.pushNamedAndRemoveUntil(context, routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  /*
  * Close dialog, page,...
  *
  * Safe when [page histories] is empty
  * */
  void back({dynamic result}) async {
    log(result.toString(), name: 'WEUP-APP');
    if (Navigator.canPop(context)) Navigator.pop(context, result);
  }
}
