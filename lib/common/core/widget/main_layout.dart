import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout<T extends BaseViewModel> extends StatelessWidget {
  const MainLayout({this.appBar, this.mustSafeView = true, required this.child, this.onClick, Key? key})
      : super(key: key);
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Function? onClick;
  final bool? mustSafeView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBackgroundPress(context),
      child: Scaffold(
        extendBody: true,
        appBar: appBar,
        body: mustSafeView == true
            ? SafeArea(child: _BodyLayout<T>(child: child))
            : _BodyLayout<T>(child: child),
      ),
    );
  }

  void _onBackgroundPress(BuildContext context) {
    FocusScope.of(context).unfocus();
    onClick?.call();
  }
}

class _BodyLayout<T extends BaseViewModel> extends StatelessWidget {
  const _BodyLayout({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<T>(
          builder: (context, value, child) => Visibility(
            visible: value.status == Status.loading || value.status == Status.waiting,
            child: IndicatorComp(status: value.status),
          ),
        ),
      ],
    );
  }
}
