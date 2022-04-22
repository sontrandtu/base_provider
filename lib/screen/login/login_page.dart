import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_state.dart';
import 'package:achitech_weup/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:achitech_weup/common/extension/app_extension.dart';
import 'package:achitech_weup/common/helper/key_language.dart';
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
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  CachedNetworkImageComp(
                      url:
                          'https://cockpit.axenu.com/api/cockpit/image/?token=ad5bf77cc0fb358931a4247452fcea&w=300&h=300&o=true&m=fitToHeight&src=/storage/uploads/2020/02/13/5e454de6a6d7bXtEn7sJS_400x400.png',
                      width: width / 2,
                      height: width / 2),
                  const SizedBox(height: 32),
                  TextFieldComp(
                    editingController: viewModel.userController,
                    onValidator: (s) => viewModel.validator(s, 0),
                    hint: KeyLanguage.userName.tl,
                    isBorder: true,
                  ),
                  const SizedBox(height: 16),
                  TextFieldComp(
                    editingController: viewModel.passwordController,
                    onValidator: (s) => viewModel.validator(s, 1),
                    hint: KeyLanguage.password.tl,
                    isInvisiblePassword: true,
                    isBorder: true,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButtonComp(
                    title: KeyLanguage.login.tl,
                    widthValue: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    borderRadius: 4,
                    onPressed: viewModel.login,
                  ),
                  SizedBox(height: height * 0.25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(KeyLanguage.askUsername.tl, style: appStyle.textTheme.bodyText1),
                      InkWellComp(
                        onTap: viewModel.register,
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                          child: Text(
                            KeyLanguage.registerNow.tl,
                            style: appStyle.textTheme.bodyText2?.apply(
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                                color: ColorResource.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Stack(
                children: [
                  CupertinoSwitchComp(
                    value: provider.currentLanguage,
                    onChanged: provider.changeSwitch,
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => provider.changeSwitch(false),
                          child: Text(
                            'VI',
                            style: appStyle.textTheme.headline5
                                ?.copyWith(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () => provider.changeSwitch(true),
                          child: Text(
                            'EN',
                            style: appStyle.textTheme.headline5?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: provider.currentLanguage ? Colors.transparent : null),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initViewModel() => viewModel = loginViewModel;
}
