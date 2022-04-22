
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_state.dart';
import 'package:achitecture_weup/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:achitecture_weup/common/core/widget/dialog/date_picker_dialog.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/main.dart';
import 'package:achitecture_weup/screen/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../common/core/widget/button/switch_comp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, child) => Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                KeyLanguage.title.tl,
                style: appStyle.textTheme.bodyText2,
              ),
              Text(
                'Current language: ${value.language}',
                style: appStyle.textTheme.bodyText2,
              ),
              TextButtonComp(
                title: 'Back',
                onPressed: () => viewModel.appNavigator.back(),
              ),TextButtonComp(
                title: 'Change Theme',
                onPressed: () => themeViewModel.toggleMode(),
              ),
              ElevatedButtonComp(
                title: 'HHHHHHHH',
                onPressed: () async {
                  DateTime? a = await viewModel.appNavigator
                      .dialog(const DatePickerComp(selectionMode: DateRangePickerSelectionMode.single));

                },
              ),
              CupertinoSwitchComp(
                value: value.valueSwitch,
                onChanged: value.changeSwitch,
              ),
              SwitchComp(
                onChanged: value.changeSwitch,
                value: value.valueSwitch,
              ),
              ElevatedButtonComp(
                title: 'HHHHHHHH',
                onPressed: () {},
              ),
              ElevatedButtonComp(
                title: 'Change language',
                onPressed: viewModel.changLanguage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initViewModel() => viewModel = HomeViewModel();
}
