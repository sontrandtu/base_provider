import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_state.dart';
import 'package:achitecture_weup/main.dart';
import 'package:achitecture_weup/screen/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashViewModel> {

  @override
  SplashViewModel get init => splashViewModel;

  @override
  Widget build(BuildContext context) {
    return MainLayout<SplashViewModel>( child: Container(),

    );
  }
}
