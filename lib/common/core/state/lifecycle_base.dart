import 'package:flutter/material.dart';

class Lifecycle {
  static const String INIT = 'initState';
  static const String FRAME_CALL_BACK = 'addPostFrameCallback';
  static const String DID_CHANGE_DEPENDENCIES = 'didChangeDependencies';
  static const String DEACTIVATE = 'deactivate';
  static const String BUILD = 'build';
  static const String DISPOSE = 'dispose';
}

abstract class LifecycleBase {
  bool mounted = false;

  TickerProvider? _vsync;

  RouteSettings? settings;

  String flagLifecycle = Lifecycle.INIT;

  TickerProvider get vsync => _vsync!;

  bool get mustCancelRequest => flagLifecycle == Lifecycle.DISPOSE;

  void setMounted(bool mounted) => this.mounted = mounted;

  void setTickerProvider(TickerProvider? tp) => _vsync = tp;

  void setRouteSetting(RouteSettings? rs) {
    mounted = true;
    settings = rs;
  }

  void setFlagLifecycle(String flag) => flagLifecycle = flag;

  /*
  * Hàm được chạy đầu tiên ngay sau khi chuyển page
  * */
  Future<void> init() async {}

  /*
  * Hàm được chạy đầu tiên ngay sau khi chuyển page
  * */
  Future<void> initialData() async {}

  /*
  * Hàm được chạy khi page đã hoàn tất tất cả frame
  *
  * Hàm được recommend thực thi liên quan đến navigation:
  * dialog, push page, buttonsheet,...
  * */
  @mustCallSuper
  void onViewCreated() => mounted = true;

  void onDeActive() {}

  @mustCallSuper
  void onDispose() {
    // setTickerProvider(null);
  }
}
