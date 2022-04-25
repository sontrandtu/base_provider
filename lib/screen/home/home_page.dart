import 'dart:developer';
import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_state.dart';
import 'package:achitecture_weup/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:achitecture_weup/common/core/widget/dialog/cupertino_picker.dart';
import 'package:achitecture_weup/common/core/widget/dialog/date_picker_custom_dialog.dart';
import 'package:achitecture_weup/common/core/widget/dialog/pick_img_bottomsheet_dialog.dart';
import 'package:achitecture_weup/common/core/widget/image/slider_comp.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/main.dart';
import 'package:achitecture_weup/screen/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SliderComp(images: [
                    'https://www.daophatngaynay.com/vn/files/images/quy1-2010/11198281229096493_456282371.jpg',
                    'https://hoithanh.com/wp-content/uploads/2015/07/b7433357-de29-4381-9cd4-9c2b8882f4c0.jpg',
                    'https://www.tapchikientruc.com.vn/wp-content/uploads/2017/12/17B12014-tckt.vn-02.jpg'
                  ]),
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
                  ),
                  TextButtonComp(
                    title: 'Change Theme',
                    onPressed: () => themeViewModel.toggleMode(),
                  ),
                  ElevatedButtonComp(
                    title: 'Date Picker',
                    onPressed: () async {
                      PickerDateRange a = await viewModel.appNavigator.dialog(
                        const DatePickerComp(),
                      );
                      log("Result Time $a");
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
                    title: 'Share App',
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        Share.share('abc');
                      } else if (Platform.isIOS) {
                        Share.share('abc');
                      }
                      //log("Result Time $a");
                    },
                  ),
                  ElevatedButtonComp(
                    title: 'Time Picker Material',
                    onPressed: () async {
                      DateTime? a = await viewModel.appNavigator.bottomSheetDialog(
                        const CupertinoPickerDialog(),
                      );
                      log("Result Time $a");
                    },
                  ),
                  ElevatedButtonComp(
                    title: 'Change language',
                    onPressed: viewModel.changLanguage,
                  ),   ElevatedButtonComp(
                    title: 'Image Picker',
                    onPressed:(){
                      viewModel.appNavigator.bottomSheetDialog(
                        const PickImgBottomSheetDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initViewModel() => viewModel = HomeViewModel();
}
