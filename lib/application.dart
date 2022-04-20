import 'package:achitech_weup/common/constant.dart';
import 'package:achitech_weup/common/core/page_manager/key_page.dart';
import 'package:achitech_weup/common/core/page_manager/page_manager.dart';
import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      navigatorKey: navigator,
      debugShowCheckedModeBanner: false,
      title: Constant.app_name,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: KeyPage.home,
      theme: appStyle,
      onGenerateRoute: generateRoute,
      debugShowMaterialGrid: false);
}
