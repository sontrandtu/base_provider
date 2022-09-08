import 'package:flutter/material.dart';
import 'package:state/state.dart';

class NavObs extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    LifecycleBase.settings = route.settings;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    LifecycleBase.settings = previousRoute?.settings;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    LifecycleBase.settings = newRoute?.settings;
  }
}
