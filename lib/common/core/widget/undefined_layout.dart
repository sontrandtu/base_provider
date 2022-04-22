
import 'package:achitecture_weup/common/core/widget/drop_keyboard.dart';
import 'package:flutter/material.dart';

class UndefinedLayout extends StatelessWidget {
  final String? name;
  const UndefinedLayout({this.name,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropKeyboard(
      child: Column(children: [
        Text(name ?? ''),
      ]),
    );
  }
}
