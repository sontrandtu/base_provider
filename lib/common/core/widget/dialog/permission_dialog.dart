import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/extension/app_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  final String title, content;

  const PermissionDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(title.toUpperCaseLetter),
            content: Text(content),
            actions: [
              TextButtonComp(
                title: KeyLanguage.cancel.tl,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButtonComp(
                title: KeyLanguage.setting.tl.toUpperCaseLetter,
                style: appStyle.textTheme.headline4!.apply(color: ColorResource.primarySwatch),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: Text(KeyLanguage.cancel.tl),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text(KeyLanguage.setting.tl),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
            ],
          );
  }
}
