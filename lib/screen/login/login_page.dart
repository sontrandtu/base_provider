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
            child: Column(
              children: [
                TextButtonComp(
                  title: provider.post?.title,
                  onPressed: updateSplash,
                ),
                TextButtonComp(
                  title: 'Next',
                  onPressed: toNewPage,
                ),
                TextButtonComp(
                  title: 'Next',
                  onPressed: logAll,
                ),
              ],
            )));
  }

  @override
  void setViewModel() => viewModel = loginViewModel;

  void updateSplash() {

    Navigator.pop(context);
  }

  toNewPage() {
   Navigator.pushNamed(context, RoutePath.home,arguments: runtimeType.toString());
  }

  logAll() {
    viewModel.initialData();
  }
}
