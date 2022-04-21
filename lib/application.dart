import 'package:achitech_weup/common/core/page_manager/page_manager.dart';
import 'package:achitech_weup/common/core/page_manager/route_path.dart';
import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:achitech_weup/view/theme_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/helper/constant.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<ThemeViewModel>(
        builder: (context, value, child) => MaterialApp(
            navigatorKey: navigator,
            debugShowCheckedModeBanner: false,
            title: Constant.app_name,
            initialRoute: RoutePath.home,
            darkTheme: ThemeManager.instance.darkTheme,
            theme: ThemeManager.instance.lightTheme,
            themeMode: value.mode,
            onGenerateRoute: generateRoute,
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            debugShowMaterialGrid: false),
      );
}
