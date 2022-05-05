import 'package:flutter/material.dart';

class AppNavigator {
  late BuildContext _context;

  void setBuildContext(BuildContext? ctx) => _context = ctx!;

  Future<dynamic> dialog(Widget dialog, {dynamic arguments, bool? barrierDismissible}) async =>
      await showDialog(
          context: _context,
          builder: (context) => dialog,
          barrierDismissible: barrierDismissible ?? false,
          routeSettings: RouteSettings(arguments: arguments));

  Future<dynamic> bottomSheetDialog(Widget dialog, {dynamic arguments}) async => await showModalBottomSheet(
      context: _context, builder: (context) => dialog, routeSettings: RouteSettings(arguments: arguments));


  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamed(_context, routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) async =>
      await Navigator.pushReplacementNamed(_context, routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamedAndRemoveUntil(_context, routeName, (Route<dynamic> route) => false,
          arguments: arguments);

  void back({dynamic result}) async {
    if (await Navigator.maybePop(_context)) Navigator.pop(_context, result);
  }
}
