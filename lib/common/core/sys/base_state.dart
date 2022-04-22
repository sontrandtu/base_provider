import 'dart:developer';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget, E extends BaseViewModel> extends State<T> {
  late E viewModel;
  double _width = 0;
  double _height = 0;

  double get width => _width;

  double get height => _height;

  RouteSettings? get routeSetting => ModalRoute.of(context)?.settings;

  void initViewModel();

  @override
  void initState() {

    super.initState();
    initViewModel();

    log('$E was installed', name: 'WEUP-APP');

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
      appStyle = Theme.of(context);
      viewModel.setRouteSetting(routeSetting);

      viewModel.setBuildContext(context);

      viewModel.initialData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    log('$E was closed', name: 'WEUP-APP');
    viewModel.onDispose();
    super.dispose();
  }
}
