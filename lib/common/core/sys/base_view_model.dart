import 'dart:io';

import 'package:achitech_weup/common/resource/enum_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ErrorCallback = Function(String?);
typedef SuccessCallback = Function(dynamic);
typedef OnLoadedCallback = Function();

class BaseViewModel extends ChangeNotifier {
  Status _status = Status.loading;

  RouteSettings? _settings;

  BuildContext? _context;

  Status get status => _status;

  BuildContext get context => _context!;

  String? get currentRoute => _settings?.name;

  Future<bool> get isConnecting async => await getConnection();

  dynamic getArguments() => _settings?.arguments;

  Future<void> initialData() async => await fetchData();

  Future<void> fetchData() async {}

  void onViewCreated() {}

  void onDispose() {}

  Future<void> delay(int millis) async => await Future.delayed(Duration(milliseconds: millis));

  Future<bool> getConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      setStatus(Status.noConnection);
      return true;
    }
  }

  void setStatus(Status s) {
    _status = s;
    update();
  }

  void setRouteSetting(RouteSettings? rs) => _settings = rs;

  void setBuildContext(BuildContext? ctx) => _context = ctx;

  Future<dynamic> dialog(Widget dialog, {dynamic arguments}) async => await showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
      routeSettings: RouteSettings(arguments: arguments));

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamed(context, routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) async =>
      await Navigator.pushReplacementNamed(context, routeName, arguments: arguments);

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) async =>
      await Navigator.pushNamedAndRemoveUntil(context, routeName, (Route<dynamic> route) => false,
          arguments: arguments);

  bool checkNull(dynamic value) {
    if (value != null) return false;
    setStatus(Status.error);
    return true;
  }

  void update() => notifyListeners();
}
