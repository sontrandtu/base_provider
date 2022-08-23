import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import 'common/helper/constant.dart';
import 'common/page_manager/page_manager.dart';
import 'common/page_manager/route_path.dart';
import 'common/theme/theme_manager.dart';
import 'common/theme/theme_view_model.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  State<Application> createState() => _ApplicationState();

  static void updateLanguage() {
    BuildContext? context = Application.navigator.currentContext;

    if (context == null) return;
    context.findAncestorStateOfType<_ApplicationState>()?.setLanguage();
  }
}

class _ApplicationState extends State<Application> {
  void setLanguage() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => Consumer<ThemeViewModel>(
        builder: (_, value, __) => MaterialApp(
          navigatorKey: Application.navigator,
          scrollBehavior: _NoScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: AppConstant.APP_NAME,
          locale: Translator().currentLocale,
          supportedLocales: Translator().supports,
          localizationsDelegates: const [
            Translator.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          themeMode: value.mode,
          theme: ThemeManager().lightTheme,
          darkTheme: ThemeManager().darkTheme,
          onGenerateRoute: generateRoute,
          initialRoute: RoutePath.INITIAL,
        ),
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
