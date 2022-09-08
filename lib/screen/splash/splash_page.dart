import 'dart:io';

import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/page_layout.dart';
import 'package:achitecture_weup/common/page_manager/route_path.dart';
import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:achitecture_weup/screen/splash/splash_view_model.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_utils/image_picker_utils.dart';
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
  File? image;
  File? finalImage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: PageLayout<SplashViewModel>(
        onReconnect: viewModel.fetchData,
        appBar: AppBarComp(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // OutlinedButtonComp(title: 'Call Data', onPressed: viewModel.fetchData),
              Consumer<SplashViewModel>(

                  builder: (context, value, child) {
                    return   OutlinedButtonComp(title: 'Change theme', onPressed: _changeTheme);
                  }),
              OutlinedButtonComp(title: 'Change language', onPressed: _changeLanguage),
              OutlinedButtonComp(title: 'Pick image', onPressed: _pickImage),
              OutlinedButtonComp(title: 'Notify listener', onPressed: _notifier),
              OutlinedButtonComp(
                  title: 'nexxt page',
                  onPressed: () => Navigator.pushNamed(context, RoutePath.LOGIN, arguments: '1 texxt arrgs')),
               const TextNomalTranslate(),
              Text(Translator().currentLocale?.languageCode == LanguageCode.EN
                  ? KeyLanguage.title.tr
                  : 'Translator().currentLanguageCode == LanguageCode.EN'),
              Text(Translator().languages.toString()),

              if (image != null) Image.file(image!),
              if (finalImage != null) Image.file(finalImage!),
            ],
          ),
        ),
      ),
    );
  }

  void _changeTheme() {
    ThemeManager().setThemeById(ThemeManager().themeId == 1 ? 0 : 1);
  }

  _changeLanguage() async {
    Translator().currentLocale?.languageCode == LanguageCode.EN
        ? Translator().setCurrentLocale(LanguageCode.VI)
        : Translator().setCurrentLocale(LanguageCode.EN);
  }

  _pickImage() async {
    // VideoManager.builder().hasCompress().build();

    await ImageManager.builder().hasCompress().single();
    // print('File Properties: ');
    // print(file?.lengthSync());
    // print(file?.lengthSync());
  }

  _notifier()async {
    viewModel.test();
    viewModel.setStatus(Status.waiting);
    await Future.delayed(Duration(seconds: 1));
    viewModel.setStatus(Status.success);
  }
}
