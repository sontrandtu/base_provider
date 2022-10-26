import 'package:achitecture_weup/common/theme/theme_manager.dart';
import 'package:achitecture_weup/screen/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets/widgets.dart';

class LanguageLayout extends StatelessWidget {
  const LanguageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<LoginViewModel>(
            builder: (context, provider, child) => CupertinoSwitchComp(
                  value: provider.currentLanguage,
                  onChanged: provider.changeSwitch,
                )),
        Positioned(
          top: 12,
          left: 12,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.read().changeSwitch(false),
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
                  onTap: () => context.read().changeSwitch(true),
                  child: Consumer<LoginViewModel>(
                    builder: (context, provider, child) => Text(
                      'EN',
                      style: appStyle.textTheme.headline5?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: provider.currentLanguage ? Colors.transparent : null),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
