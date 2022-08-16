import 'package:achitecture_weup/common/core/widget/appbar_comp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resource/enum_resource.dart';
import '../state/base_view_model.dart';
import 'indicator_comp.dart';

class MainLayout<T extends BaseViewModel> extends StatelessWidget {
  const MainLayout({
    this.appBar,
    this.mustSafeView = true,
    required this.child,
    this.radius = 32,
    this.onClick,
    this.backgroundColor,
    Key? key,
    this.resizeToAvoidBottomInset,
    this.endDrawer,
    this.scaffoldKey,
    this.onEndDrawerChanged,
  }) : super(key: key);
  final Widget child;
  final Widget? endDrawer;
  final PreferredSizeWidget? appBar;
  final Function()? onClick;
  final bool? mustSafeView;
  final bool? resizeToAvoidBottomInset;
  final double radius;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final DrawerCallback? onEndDrawerChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBackgroundPress(context),
      child: Scaffold(
        key: scaffoldKey,
        extendBody: true,
        appBar: appBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        body: mustSafeView == true
            ? SafeArea(
                child: _BodyLayout<T>(
                child: child,
                radius: radius,
              ))
            : _BodyLayout<T>(
                child: child,
                radius: radius,
              ),
      ),
    );
  }

  void _onBackgroundPress(BuildContext context) {
    FocusScope.of(context).unfocus();
    onClick?.call();
  }
}

class _BodyLayout<T extends BaseViewModel> extends StatelessWidget {
  const _BodyLayout({Key? key, required this.child, required this.radius}) : super(key: key);
  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, left: 0, right: 0, bottom: 0, child: child),
        Positioned.fill(
          child: Consumer<T>(
            builder: (context, value, child) {
              if (value.status == Status.firstIssue) {
                return Scaffold(extendBody: true, appBar: AppBarComp(height: 0));
              }
              if (value.status == Status.error) return const SizedBox();

              bool condition = value.status == Status.loading || value.status == Status.waiting;
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: _buildTransition,
                child: condition ? IndicatorComp(status: value.status) : const SizedBox(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  }
}
