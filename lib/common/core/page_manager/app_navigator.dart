import 'package:flutter/material.dart';

/*
* Thực hiện các navigation không cần context
*
* */
class AppNavigator {
  late BuildContext _context;

  void setBuildContext(BuildContext? ctx) => _context = ctx!;

  /*
  * Hiển thị dialog
  * */
  Future<dynamic> dialog(Widget dialog,
          {dynamic arguments, bool? barrierDismissible}) async =>
      await showDialog(
          context: _context,
          builder: (context) => dialog,
          barrierDismissible: barrierDismissible ?? false,
          routeSettings: RouteSettings(arguments: arguments));

  /*
  * Hiển thị bottomSheet
  * */
  Future<dynamic> bottomSheetDialog(Widget dialog, {dynamic arguments}) async =>
      await showModalBottomSheet(
          context: _context,
          builder: (context) => dialog,
          routeSettings: RouteSettings(arguments: arguments));

  /*
  * Navigate to new page with [RouteName]
  * */
  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamed(_context, routeName, arguments: arguments);

  /*
  * Navigate to new page with [RouteName] and replace [current page]
  * */
  Future<dynamic> pushReplacementNamed(String routeName,
          {dynamic arguments}) async =>
      await Navigator.pushReplacementNamed(_context, routeName,
          arguments: arguments);

  /*
  * Navigate to new page with [RouteName] and replace all util pages
  * */
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
          {dynamic arguments}) async =>
      await Navigator.pushNamedAndRemoveUntil(
          _context, routeName, (Route<dynamic> route) => false,
          arguments: arguments);

  /*
  * Close Dialog, bottomsheet
  * */
  Future<dynamic> pop([dynamic result]) async =>
      Navigator.pop(_context, result);

  /*
  * Close dialog, page,...
  *
  * Safe when [page histories] is empty
  * */
  void back({dynamic result}) async {
    if (await Navigator.maybePop(_context)) Navigator.pop(_context, result);
  }
}
