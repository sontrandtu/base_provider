import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_state.dart';
import 'package:achitech_weup/main.dart';
import 'package:achitech_weup/screen/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginViewModel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (_, provider, __) => DropKeyboard(
            status: provider.status,
            child: BaseTextButton(
              title: 'Update Home',
              onTab: updateSplash,
            )));
  }

  @override
  void setViewModel() => viewModel = loginViewModel;

  void updateSplash() {
    splashViewModel.data = '123123123';
    splashViewModel.update();
    Navigator.pop(context);
  }
}
