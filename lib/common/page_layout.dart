import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state/state.dart';
import 'package:widgets/widgets.dart';

class PageLayout<T extends BaseViewModel> extends StatelessWidget {
  const PageLayout({
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
            ? SafeArea(child: _BodyLayout<T>(child: child, radius: radius, onReconnect: onReconnect))
            : _BodyLayout<T>(child: child, radius: radius, onReconnect: onReconnect),
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
          child: Consumer<T>(
            builder: (context, value, child) {
              if (value.status == Status.firstIssue) {
                return const Scaffold(extendBody: true, body: ErrorLayout());
              }
              if (value.status == Status.connection) {
                return Scaffold(extendBody: true, body: NoConnectLayout(onReconnect: onReconnect));
              }
              if (value.status == Status.success) value.setFlagLifecycle(Lifecycle.BUILD);
              if (value.status == Status.error) return const SizedBox();

              bool condition = value.status == Status.loading || value.status == Status.waiting;
              if (value.status == Status.loading) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: _buildTransition,
                  child: condition
                      ? Container(alignment: Alignment.center,color: Colors.white, child: const IndicatorComp())
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
