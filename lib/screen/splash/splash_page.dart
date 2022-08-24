import 'package:achitecture_weup/common/page_layout.dart';
import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:achitecture_weup/screen/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/state.dart';
import 'package:widgets/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashViewModel> with AutomaticKeepAliveClientMixin {
  @override
  SplashViewModel get init => SplashViewModel();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: PageLayout<SplashViewModel>(
        onReconnect: viewModel.fetchData,
        appBar: AppBarComp(),
        child: Column(
          children: [
            OutlinedButtonComp(title: 'Call Data',onPressed: viewModel.fetchData,),
            OutlinedButtonComp(title: 'Change theme',onPressed: _changeTheme,),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _changeTheme() {
    ThemeManager().setThemeById(ThemeManager().themeId == 1? 0: 1);
  }
}
