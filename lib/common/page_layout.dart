import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/state.dart';
import 'package:widgets/widgets.dart';

class PageLayout<T extends BaseViewModel> extends StatelessWidget {
  const PageLayout({
    this.appBar,
    this.mustSafeView = true,
    required this.child,
    this.radius = 0,
    this.onClick,
    this.backgroundColor,
    Key? key,
    this.resizeToAvoidBottomInset,
    this.endDrawer,
    this.scaffoldKey,
    this.onEndDrawerChanged,
    this.onReconnect,
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
  final OnReconnect? onReconnect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBackgroundPress(context),
      child: Scaffold(
        // key: scaffoldKey,
        extendBody: true,
        appBar: appBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        // endDrawer: endDrawer,
        // onEndDrawerChanged: onEndDrawerChanged,
        body: mustSafeView == true
            ? SafeArea(child: _BodyLayout<T>(radius: radius, onReconnect: onReconnect, child: child))
            : _BodyLayout<T>(radius: radius, onReconnect: onReconnect, child: child),
      ),
    );
  }

  void _onBackgroundPress(BuildContext context) {
    // FocusScope.of(context).unfocus();
    onClick?.call();
  }
}

class _BodyLayout<T extends BaseViewModel> extends StatelessWidget {
  const _BodyLayout({Key? key, required this.child, required this.radius, this.onReconnect})
      : super(key: key);
  final Widget child;
  final double radius;
  final OnReconnect? onReconnect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned.fill(
          child: Selector<T, Status>(
            selector: (_, p1) => p1.status,
            builder: (context, value, child) {
              if (value == Status.firstIssue) {
                return const Scaffold(extendBody: true, body: ErrorLayout());
              }
              if (value == Status.connection) {
                return Scaffold(extendBody: true, body: NoConnectLayout(onReconnect: onReconnect));
              }
              if (value == Status.success) context.read<T>().setFlagLifecycle(Lifecycle.BUILD);
              if (value == Status.error) return const SizedBox();

              bool condition = value == Status.loading || value == Status.waiting;
              if (value == Status.loading) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: _buildTransition,
                  child: condition
                      ? Container(
                          alignment: Alignment.center, color: Colors.white, child: const IndicatorComp())
                      : const SizedBox(),
                );
              }
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: _buildTransition,
                child: condition ? const IndicatorComp() : const SizedBox(),
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
