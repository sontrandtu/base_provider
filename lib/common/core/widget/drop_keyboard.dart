
import 'package:achitech_weup/common/app_common.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

import 'base_indicator.dart';

class DropKeyboard extends StatelessWidget {
  final Widget child;
  final Status? status;
  final Function? onClick;

  const DropKeyboard({this.status, required this.child, this.onClick, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onClick?.call();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              child,
              Positioned(
                top: 0,
                child: Visibility(
                  visible: status == Status.waiting,
                  child: const BaseIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
