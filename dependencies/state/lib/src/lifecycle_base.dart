import 'package:flutter/material.dart';

class Lifecycle {
  static const String INIT = 'initState';
  static const String FRAME_CALL_BACK = 'addPostFrameCallback';
  static const String DID_CHANGE_DEPENDENCIES = 'didChangeDependencies';
  static const String DEACTIVATE = 'deactivate';
  static const String BUILD = 'build';
  static const String DISPOSE = 'dispose';
}

mixin LifecycleBase {
  bool mounted = false;

  TickerProvider? _vsync;

  String flagLifecycle = Lifecycle.INIT;

  void setMounted(bool mounted) => this.mounted = mounted;

  void setTickerProvider(TickerProvider? tp) => _vsync = tp;

  void setFlagLifecycle(String flag) => flagLifecycle = flag;

  TickerProvider get vsync => _vsync!;

  /*
  * Hàm được chạy đầu tiên ngay sau khi chuyển page
  * */
  Future<void> init() async {}

  /*
  * Hàm được chạy khi page đã hoàn tất tất cả frame
  *
  * Hàm được recommend thực thi liên quan đến navigation:
  * dialog, push page, buttonsheet,...
  * */
  Future<void> onViewCreated() async {}

  void onDeActive() {}

  @mustCallSuper
  void onDispose() {
    // setTickerProvider(null);
  }
}
