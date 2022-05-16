import 'dart:developer';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_state.dart';
import 'package:achitecture_weup/common/core/widget/dialog/custom_dialog.dart';
import 'package:achitecture_weup/common/core/widget/form_album.dart';
import 'package:achitecture_weup/common/core/widget/form_number.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/helper/image_utils/image_utils.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:achitecture_weup/main.dart';
import 'package:achitecture_weup/screen/home/components/item_todo.dart';
import 'package:achitecture_weup/screen/home/home_view_model.dart';
import 'package:achitecture_weup/screen/login/login_page.dart';
import 'package:achitecture_weup/screen/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeViewModel> {
  String radioValue1 = 'a';
  String radioValue2 = 'b';
  String groupRadio = 'e';

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
  }

  final jobRoleCtrl = TextEditingController();
  String urlImage = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (context, child) => Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FormAlbum(
                    onChanged: (val) {},
                  ),
                  FormNumber(
                    value: 5,
                    onChanged: (int value) {},
                    max: 10,
                    min: 1,
                  ),
                  ImageViewer(urlImage, width: 100, height: 100),

                  const ImageViewer(
                    '',
                  ),
                  // const SliderComp(images: [
                  //   'https://www.daophatngaynay.com/vn/files/images/quy1-2010/1119828829096493_456282371.jpg',
                  //   'https://hoithanh.com/wp-content/uploads/2015/07/b7433357-de29-4381-9cd4-9c2b8882f4c0.jpg',
                  //   'https://www.tapchikientruc.com.vn/wp-content/uploads/2017/8/17B8014-tckt.vn-02.jpg'
                  // ]),
                  // Text(
                  //   KeyLanguage.title.tl,
                  //   style: appStyle.textTheme.bodyText2,
                  // ),
                  // Text(
                  //   'Current language: ${value.language}',
                  //   style: appStyle.textTheme.bodyText2,
                  // ),
                  // TextButtonComp(
                  //   title: 'Back',
                  //   onPressed: () => value.appNavigator.back(),
                  // ),
                  TextButtonComp(
                    title: 'Change Theme',
                    onPressed: () => themeViewModel.toggleMode(),
                  ),
                  // ElevatedButtonComp(
                  //   title: 'Date Picker',
                  //   onPressed: () async {
                  //     PickerDateRange a = await value.appNavigator.dialog(
                  //       const DatePickerComp(),
                  //     );
                  //     log("Result Time $a");
                  //   },
                  // ),
                  // CupertinoSwitchComp(
                  //   value: value.valueSwitch,
                  //   onChanged: value.changeSwitch,
                  // ),
                  // SwitchComp(
                  //   onChanged: value.changeSwitch,
                  //   value: value.valueSwitch,
                  // ),
                  // ElevatedButtonComp(
                  //   title: 'Share App',
                  //   onPressed: () async {
                  //     if (Platform.isAndroid) {
                  //       Share.share('abc');
                  //     } else if (Platform.isIOS) {
                  //       Share.share('abc');
                  //     }
                  //     //log("Result Time $a");
                  //   },
                  // ),
                  ElevatedButtonComp(
                    title: 'Time Picker Material',
                    onPressed: () async {
                      DateTime? a = await viewModel.appNavigator.bottomSheetDialog(
                        const CupertinoPickerDialog(),
                      );
                    },
                  ),
                  ElevatedButtonComp(
                    title: 'Change language',
                    onPressed: viewModel.changLanguage,
                  ),
                  // CheckBoxComp(
                  //   value: value.valueSwitch,
                  //   onChanged: value.changeSwitch,
                  //   side: const BorderSide(width: 1),
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  // ),
                  // RadioCustomComp<String>(
                  //   value: value.radioValue1,
                  //   groupValue: value.groupRadio,
                  //   onChanged: value.changeRadio,
                  //   widgetDefault: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: Colors.grey.withOpacity(0.5),
                  //     ),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         Icons.male_rounded,
                  //         color: Colors.blue,
                  //       ),
                  //     ),
                  //   ),
                  //   widgetSelected: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: Colors.blue,
                  //     ),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         Icons.male_rounded,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // RadioCustomComp<String>(
                  //   value: value.radioValue2,
                  //   groupValue: value.groupRadio,
                  //   onChanged: value.changeRadio,
                  //   widgetDefault: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: Colors.grey.withOpacity(0.5),
                  //     ),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         Icons.female_rounded,
                  //         color: Colors.pinkAccent,
                  //       ),
                  //     ),
                  //   ),
                  //   widgetSelected: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: Colors.pinkAccent,
                  //     ),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         Icons.female_rounded,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Wrap(
                  //   children: [
                  //     CheckBoxCustomComp(
                  //       value: value.val_1,
                  //       onChanged: value.changeSwitch1,
                  //       widgetDefault: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  //           child: Text(
                  //             'Tennis',
                  //             style: appStyle.textTheme.bodyText2!.apply(color: Colors.grey.withOpacity(0.5)),
                  //           ),
                  //         ),
                  //       ),
                  //       widgetSelected: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           border: Border.all(color: ColorResource.primarySwatch),
                  //           color: ColorResource.primarySwatch,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  //           child: Text(
                  //             'Tennis',
                  //             style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     CheckBoxCustomComp(
                  //       value: value.val_2,
                  //       onChanged: value.changeSwitch2,
                  //       widgetDefault: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  //           child: Text(
                  //             'Base Ball',
                  //             style: appStyle.textTheme.bodyText2!.apply(color: Colors.grey.withOpacity(0.5)),
                  //           ),
                  //         ),
                  //       ),
                  //       widgetSelected: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           border: Border.all(color: ColorResource.primarySwatch),
                  //           color: ColorResource.primarySwatch,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  //           child: Text(
                  //             'Base Ball',
                  //             style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     CheckBoxCustomComp(
                  //       value: value.val_3,
                  //       onChanged: value.changeSwitch3,
                  //       widgetDefault: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  //           child: Text(
                  //             'Swim',
                  //             style: appStyle.textTheme.bodyText2!.apply(color: Colors.grey.withOpacity(0.5)),
                  //           ),
                  //         ),
                  //       ),
                  //       widgetSelected: Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           border: Border.all(color: ColorResource.primarySwatch),
                  //           color: ColorResource.primarySwatch,
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  //           child: Text(
                  //             'Swim',
                  //             style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 100,
                    child: BottomBarFabComp(
                      onChangeTab: (int value) => log('RRRR $value'),
                      body: Container(
                        color: Colors.blue,
                      ),
                      onPressedFAB: (){},
                    ),
                  ),
                  RadioCustomComp<String>(
                    value: value.radioValue2,
                    groupValue: value.groupRadio,
                    onChanged: value.changeRadio,
                    widgetDefault: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.female_rounded,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                    widgetSelected: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.pinkAccent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.female_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      CheckBoxCustomComp(
                        value: value.val_1,
                        onChanged: value.changeSwitch1,
                        widgetDefault: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            child: Text(
                              'Tennis',
                              style: appStyle.textTheme.bodyText2!.apply(color: Colors.grey.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        widgetSelected: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorResource.primarySwatch),
                            color: ColorResource.primarySwatch,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            child: Text(
                              'Tennis',
                              style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      CheckBoxCustomComp(
                        value: value.val_2,
                        onChanged: value.changeSwitch2,
                        widgetDefault: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            child: Text(
                              'Base Ball',
                              style: appStyle.textTheme.bodyText2!.apply(color: Colors.grey.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        widgetSelected: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorResource.primarySwatch),
                            color: ColorResource.primarySwatch,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            child: Text(
                              'Base Ball',
                              style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      CheckBoxCustomComp(
                        value: value.val_3,
                        onChanged: value.changeSwitch3,
                        widgetDefault: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            child: Text(
                              'Swim',
                              style: appStyle.textTheme.bodyText2!.apply(color: Colors.grey.withOpacity(0.5)),
                            ),
                          ),
                        ),
                        widgetSelected: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorResource.primarySwatch),
                            color: ColorResource.primarySwatch,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                            child: Text(
                              'Swim',
                              style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  PositionAniButtonComp(
                    onPressed: value.nextPage,
                    child: const Text(
                      'Simple button1111',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  ScaleAniButtonComp(
                    onPressed: () async {
                      urlImage =
                          await viewModel.appNavigator.bottomSheetDialog(const PickImgBottomSheetDialog());
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blue,
                      child: const Text(
                        'Simple button',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  MultipleSelectComp<A>(
                    onChange: value.onChangeMultiple,
                    listItems: value.listMultipleData,
                  ),

                  TextButtonComp(
                    title: 'Open dialog',
                    onPressed: () => showDialog(
                        builder: (context) => CupertinoAlertDialog(
                          title: Text('abc'),
                          content: Text('sub'),

                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: Text(KeyLanguage.cancel.tl),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: false,
                              child: Text(KeyLanguage.setting.tl),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ), context: context),
                  ),
                  TextButtonComp(
                      title: 'Open step fix',
                      onPressed: () => viewModel.appNavigator.pushNamed(RoutePath.STEPPER_FIX, arguments: [
                            const LoginPage(),
                            const SplashPage(),
                            const LoginPage(),
                          ])),
                  TextButtonComp(title: 'To todo list page', onPressed: () =>viewModel.appNavigator.pushNamed(RoutePath.TODO_LIST)),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel get init => HomeViewModel();


}

class A {
  String? hovaTen;
  int? tuoi;

  A({this.hovaTen, this.tuoi});
}
