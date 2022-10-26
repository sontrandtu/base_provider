import 'package:state/src/nav_obs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translator/translator.dart';

import 'common/helper/constant.dart';
import 'common/page_manager/page_manager.dart';
import 'common/page_manager/route_path.dart';
import 'common/theme/theme_manager.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  static final GlobalKey materialKey = GlobalKey();

  @override
  Widget build(BuildContext context) => MaterialApp(
        key: materialKey,
        navigatorKey: Application.navigator,
        scrollBehavior: _NoScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: AppConstant.APP_NAME,
        locale: Translator().currentLocale,
        supportedLocales: Translator().supports,
        theme: ThemeManager().value,
        navigatorObservers: [NavObs()],
        localizationsDelegates: [
          ApplicationLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        onGenerateRoute: generateRoute,

        // routes: routes,
        initialRoute: RoutePath.INITIAL,
      );
}

class _NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const ClampingScrollPhysics();
}
