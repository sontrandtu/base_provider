import 'package:achitecture_weup/common/helper/view_utils.dart';
import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:achitecture_weup/screen/login/components/language_layout.dart';
import 'package:achitecture_weup/screen/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/state.dart';
import 'package:translator/translator.dart';
import 'package:widgets/widgets.dart';

import '../../application.dart';
import '../../common/page_layout.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginViewModel> {
  @override
  LoginViewModel get init => LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: PageLayout<LoginViewModel>(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: ViewUtils.height - ViewUtils.heightStatusBar,
                width: ViewUtils.width,
                constraints: BoxConstraints(maxHeight: ViewUtils.height - ViewUtils.heightStatusBar),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    CachedNetworkImageComp(
                        url:
                            'https://cockpit.axenu.com/api/cockpit/image/?token=ad5bf77cc0fb358931a4247452fcea&w=300&h=300&o=true&m=fitToHeight&src=/storage/uploads/2020/02/13/5e454de6a6d7bXtEn7sJS_400x400.png',
                        width: ViewUtils.width / 2.5,
                        height: ViewUtils.width / 2.5),
                    const SizedBox(height: 32),
                    const OutlineInput(
                      labelText: 'User Name',
                      obscureText: true,
                    ),

                    // TextFieldComp(
                    //   editingController: viewModel.userController,
                    //   onValidator: (s) => viewModel.validator(s, 0),
                    //   hint: KeyLanguage.userName.tl,
                    //   isBorder: true,
                    // ),
                    const SizedBox(height: 16),
                    const UnderlineInput(
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    // TextFieldComp(
                    //   editingController: viewModel.passwordController,
                    //   onValidator: (s) => viewModel.validator(s, 1),
                    //   hint: KeyLanguage.password.tl,
                    //   isInvisiblePassword: true,
                    //   isBorder: true,
                    // ),
                    const SizedBox(height: 32),
                    ElevatedButtonComp(
                      title: 'KeyLanguage.login.tr',
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      borderRadius: 4,
                      onPressed: viewModel.login,
                    ),
                    Text(KeyLanguage.title.tr),
                    OutlinedButtonComp(title: 'Change language', onPressed: _changeLanguage),
                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('KeyLanguage.askUsername.tl', style: appStyle.textTheme.bodyText1),
                        InkWellComp(
                          onTap: viewModel.register,
                          backgroundColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                            child: Text(
                              'KeyLanguage.registerNow.tl',
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
            ),
            const Positioned(top: 0, right: 0, child: LanguageLayout())
          ],
        ),
      ),
    );
  }
  _changeLanguage() async{
    Translator().currentLocale?.languageCode == LanguageCode.EN
        ? Translator().setCurrentLocale(LanguageCode.VI)
        : Translator().setCurrentLocale(LanguageCode.EN);
  }
}
