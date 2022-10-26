import 'package:flutter/material.dart';
import 'package:state/src/routing/routing.dart';

import 'routing/app_routing.dart';

class NavObs extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    AppRouting.setRouting(Routing(settings: route.settings));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    AppRouting.setRouting(Routing(settings: previousRoute?.settings));
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    AppRouting.setRouting(Routing(settings: newRoute?.settings));
  }
}
