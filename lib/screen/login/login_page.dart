import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_state.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: SizedBox()),
                  TextFieldComp(
                    hint: 'Tên tài khoản',
                    isBorder: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFieldComp(
                    hint: 'Mật khẩu',
                    isBorder: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButtonComp(
                    title: 'Click me',
                    widthValue: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    borderRadius: 4,
                    onPressed: _login,
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bạn chưa có tài khoản?', style: appStyle.textTheme.bodyText1),
                      InkWell(
                        onTap: _register,
                        splashColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            'Đăng ký ngay',
                            style: appStyle.textTheme.bodyText1?.apply(
                                decoration: TextDecoration.underline,
                                color: ColorResource.primary,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            )));
  }

  @override
  void setViewModel() => viewModel = loginViewModel;

  Future<void> _login() async {
    viewModel.login();
  }

  void _register() {}
}
