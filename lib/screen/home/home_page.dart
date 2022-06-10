import 'dart:developer';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_state.dart';
import 'package:achitecture_weup/common/core/widget/ani_appbar_title_comp.dart';
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


  @override
  void initState() {
    super.initState();
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
            child: AniAppBarTitle(),
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
