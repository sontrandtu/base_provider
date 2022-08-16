import 'package:achitecture_weup/common/core/widget/ani_appbar_title_comp.dart';
import 'package:achitecture_weup/screen/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/core/state/base_state.dart';

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
