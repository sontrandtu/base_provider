import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class DropKeyboard extends StatelessWidget {
  const DropKeyboard({this.appBar, this.status, required this.child, this.onClick, Key? key})
      : super(key: key);
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Status? status;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onClick?.call();
      },
      child: Scaffold(
        extendBody: true,
        appBar: appBar,
        body: SafeArea(
          child: Stack(children: [
            Visibility(visible: status != Status.errorInit && status != Status.loading, child: child),
            Visibility(
              visible: status == Status.loading || status == Status.waiting,
              child: const IndicatorComp(),
            ),
          ]),
        ),
      ),
    );
  }
}
