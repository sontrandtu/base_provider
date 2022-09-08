import 'package:flutter/material.dart';

/*
* Thực hiện các navigation không cần context
*
* */
class AppNavigator {
  BuildContext? _context;

  double get width => MediaQuery.of(_context!).size.width;

  double get height => MediaQuery.of(_context!).size.height;

  BuildContext get context => _context!;

  void setBuildContext(BuildContext? ctx) => _context = ctx;

  /*
  * Hiển thị dialog
  * */
  Future<dynamic> dialog(Widget dialog, {dynamic arguments, bool? barrierDismissible}) async {
    if (_context == null) return;
    return await showGeneralDialog(
      context: _context!,
      transitionDuration: Duration(milliseconds: ModalRoute.of(context)?.isCurrent == true ? 300 : 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          child: child,
          scale: Tween<double>(end: 1, begin: ModalRoute.of(context)?.isCurrent == true ? 1.3 : 0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.00, curve: Curves.linear),
            ),
          ),
        );
      },
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      routeSettings: RouteSettings(arguments: arguments),
      pageBuilder: (animation, secondaryAnimation, child) {
        return dialog;
      },
    );
  }

  /*
  * Hiển thị bottomSheet
  * */
  Future<dynamic> bottomSheetDialog(Widget dialog, {dynamic arguments}) async {
    if (_context == null) return;
    return await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        context: _context!,
        builder: (context) => dialog,
        routeSettings: RouteSettings(arguments: arguments));
  }

  Future<dynamic> push(dynamic page, {dynamic arguments}) async {
    if (_context == null) return;
    return await Navigator.push(
      _context!,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => page,
      ),
    );
  }

  /*
  * Navigate to new page with [RouteName]
  * */
  Future<dynamic> pushNamed(String routeName, {dynamic arguments, Map<String, String>? parameters}) async {
    if (_context == null) return;
    if (parameters != null) {
      final uri = Uri(path: routeName, queryParameters: parameters);
      routeName = uri.toString();
    }
    return await Navigator.pushNamed(_context!, routeName, arguments: arguments);
  }

  /*
  * Navigate to new page with [RouteName] and replace [current page]
  * */
  Future<dynamic> pushReplacementNamed(String routeName,
      {dynamic arguments, Map<String, String>? parameters, dynamic result}) async {
    if (_context == null) return;
    if (parameters != null) {
      final uri = Uri(path: routeName, queryParameters: parameters);
      routeName = uri.toString();
    }

    return await Navigator.pushReplacementNamed(_context!, routeName, arguments: arguments, result: result);
  }

  /*
  * Navigate to new page with [RouteName] and replace all util pages
  * */
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {dynamic arguments, Map<String, String>? parameters}) async {
    if (_context == null) return;
    if (parameters != null) {
      final uri = Uri(path: routeName, queryParameters: parameters);
      routeName = uri.toString();
    }
    return await Navigator.pushNamedAndRemoveUntil(
      _context!,
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  /*
  * Close dialog, page,...
  *
  * Safe when [page histories] is empty
  * */
  void back({dynamic result}) async {
    if (_context == null) return;
    // log(result.toString(), name: 'WEUP-APP');
    await Navigator.maybePop(_context!, result);
  }

  void pop({dynamic result}) async {
    if (_context == null) return;
    Navigator.pop(_context!, result);
  }

  void popUntil(String routePath) async {
    if (_context == null) return;
    Navigator.popUntil(_context!, ModalRoute.withName(routePath));
  }

  void hideKeyboard() => FocusScope.of(_context!).unfocus();
}
