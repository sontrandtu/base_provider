import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/src/status.dart';

import 'base_view_model.dart';
import 'lifecycle_base.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel> extends State<T> {
  VM? _viewModel;

  VM get viewModel => _viewModel!;

  VM get init => context.read<VM>();

  TickerProvider? get vsync => null;

  @override
  void initState() {
    _viewModel = init;

    _viewModel?.setFlagLifecycle(Lifecycle.INIT);

    _viewModel?.setTickerProvider(vsync);

    _viewModel?.setMounted(false);

    _viewModel?.setStatus(Status.loading);

    _viewModel?.setBuildContext(context);

    _viewModel?.init();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('$VM was installed ${DateTime.now()}');


      _viewModel?.setMounted(mounted);

      _viewModel?.setFlagLifecycle(Lifecycle.INIT);

      _viewModel?.onViewCreated();

      // await _viewModel?.initialData();
    });
    super.initState();
  }

  @override
  void deactivate() {
    _viewModel?.onDeActive();

    log('$VM deActive');
    super.deactivate();
  }

  @override
  void dispose() {
    _viewModel?.setFlagLifecycle(Lifecycle.DISPOSE);
    _viewModel?.onDispose();
    _viewModel = null;

    log('$VM was closed ${DateTime.now()}');
    super.dispose();
  }
}
