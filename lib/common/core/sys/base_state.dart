import 'dart:developer';

import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseState<T extends StatefulWidget, E extends BaseViewModel> extends State<T> {
  late E viewModel;
  double _width = 0;
  double _height = 0;

  double get width => _width;

  double get height => _height;

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void setViewModel();

  @override
  void initState() {
    super.initState();
    log('$E was installed', name: 'WEUP-APP');
    setViewModel();
    viewModel.initialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    viewModel.onViewCreated();
  }


  @override
  void dispose() {
    log('$E was closed', name: 'WEUP-APP');
    viewModel.onDispose();
    super.dispose();
  }

}
