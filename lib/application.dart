import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:translator/translator.dart';

import 'common/helper/constant.dart';
import 'common/page_manager/page_manager.dart';
import 'common/page_manager/route_path.dart';
import 'common/theme/theme_manager.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  State<Application> createState() => _ApplicationState();


}

class _ApplicationState extends State<Application> {
  void updateState() {
    if (mounted) setState(() {});
  }

  static final GlobalKey materialKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    ThemeManager().init();
  }

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
        localizationsDelegates: [
          ApplicationLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        onGenerateRoute: generateRoute,
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
