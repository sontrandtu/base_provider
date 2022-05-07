import 'dart:developer';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel> extends State<T> {
  VM? _viewModel;
  double _width = 0;
  double _height = 0;

  VM get viewModel => _viewModel!;

  double get width => _width;

  double get height => _height;

  // RouteSettings? get routeSetting => ModalRoute.of(context)?.settings;

  VM get init;

  @override
  void initState() {
    _viewModel = init;

    super.initState();

    log('$VM was installed', name: 'WEUP-APP-${DateTime.now()}');

    WidgetsBinding.instance?.addPostFrameCallback((_) => _viewModel?.onViewCreated());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies', name: 'WEUP-APP-${DateTime.now()}');
    appStyle = Theme.of(context);

    _viewModel?.setBuildContext(context);

    _viewModel?.initialData();

    _width = MediaQuery.of(context).size.width;

    _height = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    _viewModel?.onDispose();
    _viewModel = null;

    log('$VM was closed', name: 'WEUP-APP');

    super.dispose();
  }
}
