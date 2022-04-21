import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class DropKeyboard extends StatelessWidget {
  const DropKeyboard({this.value, this.status, required this.child, this.onClick, Key? key})
      : super(key: key);
  final Widget child;
  final Status? status;
  final BaseViewModel? value;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onClick?.call();
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(children: [
            child,
            Visibility(
              visible: status == Status.loading,
              child: const BaseIndicator(),
            ),
          ]),
        ),
      ),
    );
  }
}
