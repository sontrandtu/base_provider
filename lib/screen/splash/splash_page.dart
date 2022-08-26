import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/page_layout.dart';
import 'package:achitecture_weup/common/page_manager/route_path.dart';
import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:achitecture_weup/screen/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/state.dart';
import 'package:translator/translator.dart';
import 'package:widgets/widgets.dart';

import 'comp/text_nomal_translate.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashViewModel> {
  @override
  SplashViewModel get init => SplashViewModel();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   Navigator.pushNamed(context, RoutePath.LOGIN);
    // });
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: PageLayout<SplashViewModel>(
        onReconnect: viewModel.fetchData,
        appBar: AppBarComp(),
        child: Column(
          children: [
            // OutlinedButtonComp(title: 'Call Data', onPressed: viewModel.fetchData),
            OutlinedButtonComp(title: 'Change theme', onPressed: _changeTheme),
            OutlinedButtonComp(title: 'Change language', onPressed: _changeLanguage),
            OutlinedButtonComp(
                title: 'nexxt page', onPressed: () => Navigator.pushNamed(context, RoutePath.LOGIN,arguments: '1 texxt arrgs')),
            TextNomalTranslate(),
            Text(Translator().currentLanguageCode == LanguageCode.EN
                ? KeyLanguage.title.tr
                : 'Translator().currentLanguageCode == LanguageCode.EN'),
            Text(Translator().languages.toString()),
          ],
        ),
      ),
    );
  }

  void _changeTheme() {
    ThemeManager().setThemeById(ThemeManager().themeId == 1 ? 0 : 1);
  }

  _changeLanguage() async {
    Translator().currentLanguageCode == LanguageCode.EN
        ? Translator().setCurrentLocale(LanguageCode.VI)
        : Translator().setCurrentLocale(LanguageCode.EN);

    Application.update();
  }
}
