import 'package:achitecture_weup/common/helper/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resource/enum_resource.dart';
import '../sys/base_function.dart';
import '../theme/theme_manager.dart';
import '../state/base_view_model.dart';
import '../state/lifecycle_base.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel> extends State<T> {
  VM? _viewModel;

  VM get viewModel => _viewModel!;

  @Deprecated('Use this to do rebuild. So it should depcrate')
  double get width => ViewUtils.width;

  @Deprecated('Use this to do rebuild. So it should depcrate')
  double get height => ViewUtils.height;

  VM get init => context.read<VM>();

  TickerProvider? get vsync => null;

  @override
  void initState() {
    _viewModel = init;

    _viewModel?.setFlagLifecycle(Lifecycle.INIT);

    _viewModel?.setTickerProvider(vsync);

    _viewModel?.setMounted(false);


    _viewModel?.setStatus(Status.loading);
    // ModalRoute.of(context)!.settings;
    _viewModel?.setBuildContext(context);

    _viewModel?.init();

    Future.delayed(Duration.zero, () => _viewModel?.onViewCreated());

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showLogState('$VM was installed ${DateTime.now()}');

      _viewModel?.setFlagLifecycle(Lifecycle.FRAME_CALL_BACK);

      _viewModel?.setMounted(mounted);

      _viewModel?.setRouteSetting(ModalRoute.of(context)?.settings);

      _viewModel?.setFlagLifecycle(Lifecycle.INIT);

      await _viewModel?.initialData();

      _viewModel?.setFlagLifecycle(Lifecycle.BUILD);
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _viewModel?.setFlagLifecycle(Lifecycle.DID_CHANGE_DEPENDENCIES);

    appStyle = Theme.of(context);
  }

  @override
  void deactivate() {
    _viewModel?.setFlagLifecycle(Lifecycle.DEACTIVATE);
    _viewModel?.onDeActive();

    showLogState('$VM deActive');
    super.deactivate();
  }

  @override
  void dispose() {
    _viewModel?.setFlagLifecycle(Lifecycle.DISPOSE);
    _viewModel?.onDispose();
    _viewModel = null;

    showLogState('$VM was closed ${DateTime.now()}');
    super.dispose();
  }
}
