import 'package:achitech_weup/common/core/widget/base_app_header.dart';
import 'package:achitech_weup/common/core/widget/drop_keyboard.dart';
import 'package:flutter/material.dart';

class UndefinedLayout extends StatelessWidget {
  final String? name;
  const UndefinedLayout({this.name,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropKeyboard(
      child: Column(children: [
        const BaseAppHeader(),
        Text(name ?? ''),
      ]),
    );
  }
}
