import 'package:achitecture_weup/common/core/page_layout.dart';
import 'package:achitecture_weup/screen/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/state.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashViewModel> {
  @override
  SplashViewModel get init => SplashViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: PageLayout<SplashViewModel>(
        child: Container(),
      ),
    );
  }
}
