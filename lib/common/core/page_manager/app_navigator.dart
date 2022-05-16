import 'dart:developer';

import 'package:flutter/material.dart';

/*
* Thực hiện các navigation không cần context
*
* */
class AppNavigator {
  late BuildContext _context;

  double get width => MediaQuery.of(_context).size.width;

  double get height => MediaQuery.of(_context).size.height;

  void setBuildContext(BuildContext? ctx) => _context = ctx!;

  /*
  * Hiển thị dialog
  * */
  Future<dynamic> dialog(Widget dialog, {dynamic arguments, bool? barrierDismissible}) async {
    log('OPEN DIALOG ${dialog.runtimeType} ${dialog.hashCode}', name: 'WEUP-APP');
    return await showDialog(
        context: _context,
        builder: (context) => dialog,
        barrierDismissible: barrierDismissible ?? false,
        routeSettings: RouteSettings(arguments: arguments));
  }

  /*
  * Hiển thị bottomSheet
  * */
  Future<dynamic> bottomSheetDialog(Widget dialog, {dynamic arguments}) async => await showModalBottomSheet(
      context: _context, builder: (context) => dialog, routeSettings: RouteSettings(arguments: arguments));

  /*
  * Navigate to new page with [RouteName]
  * */
  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamed(_context, routeName, arguments: arguments);

  /*
  * Navigate to new page with [RouteName] and replace [current page]
  * */
  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments, dynamic result}) async =>
      await Navigator.pushReplacementNamed(_context, routeName, arguments: arguments, result: result);

  /*
  * Navigate to new page with [RouteName] and replace all util pages
  * */
  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamedAndRemoveUntil(_context, routeName, (Route<dynamic> route) => false,
          arguments: arguments);

  /*
  * Close dialog, page,...
  *
  * Safe when [page histories] is empty
  * */
  void back({dynamic result}) async {
    log(result.toString(), name: 'WEUP-APP');
    if (Navigator.canPop(_context)) Navigator.pop(_context, result);
  }
}
