import 'package:achitech_weup/common/core/page_manager/page_manager.dart';
import 'package:achitech_weup/common/core/page_manager/route_path.dart';
import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'common/helper/constant.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: navigator,
    theme: appStyle,
    onGenerateRoute: generateRoute,
    debugShowCheckedModeBanner: false,
    title: Constant.app_name,
    initialRoute: RoutePath.initial,
    locale: context.locale,
    localizationsDelegates: context.localizationDelegates,
    supportedLocales: context.supportedLocales,
  );
}
