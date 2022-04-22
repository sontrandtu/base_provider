import 'package:achitecture_weup/common/core/sys/stateless_provider.dart';
import 'package:achitecture_weup/common/core/theme/theme_manager.dart';
import 'package:achitecture_weup/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:achitecture_weup/screen/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageLayout extends StatelessProvider<LoginViewModel> {
  const LanguageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, provider, child) => Stack(
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
                  onTap: () => viewModel.changeSwitch(false),
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
                  onTap: () => viewModel.changeSwitch(true),
                  child: Text(
                    'EN',
                    style: appStyle.textTheme.headline5?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: viewModel.currentLanguage ? Colors.transparent : null),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
