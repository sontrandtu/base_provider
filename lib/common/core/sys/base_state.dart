import 'dart:developer';

import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseState<T extends StatefulWidget, E extends BaseViewModel> extends State<T> {
  late E viewModel;
  double _width = 0;
  double _height = 0;

  double get width => _width;

  double get height => _height;

  RouteSettings? get routeSetting => ModalRoute.of(context)?.settings;

  void hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void setViewModel();

  @override
  void initState() {  setViewModel();
    super.initState();



    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;

      viewModel.onViewCreated();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel.setRouteSetting(routeSetting);
    log('$E was installed', name: 'WEUP-APP');

    viewModel.initialData();
  }

  @override
  void dispose() {
    log('$E was closed', name: 'WEUP-APP');
    viewModel.onDispose();
    super.dispose();
  }
}
