import 'package:achitech_weup/common/core/page_manager/app_setting.dart';
import 'package:achitech_weup/common/core/widget/base_app_header.dart';
import 'package:achitech_weup/common/core/widget/drop_keyboard.dart';
import 'package:flutter/material.dart';

class UndefinedLayout extends StatelessWidget {
  const UndefinedLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropKeyboard(
      child: Column(children: [
        const BaseAppHeader(),
        Text(AppSetting.routePath),
      ]),
    );
  }
}
