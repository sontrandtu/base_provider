import 'dart:io';

import 'package:achitech_weup/common/resource/enum_resource.dart';
import 'package:flutter/widgets.dart';

typedef ErrorCallback = Function(String?);
typedef SuccessCallback = Function(dynamic);
typedef OnLoadedCallback = Function();

class BaseViewModel extends ChangeNotifier {
  Status _status = Status.loading;

  RouteSettings? _settings;

  Status get status => _status;



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

  void setRouteSetting(RouteSettings? rs){
    _settings = rs;
  }

  bool checkNull(dynamic value) {
    if (value != null) return false;
    setStatus(Status.error);
    return true;
  }

  void update() => notifyListeners();
}
