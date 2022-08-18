import 'dart:io';

import 'package:extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';

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
              TextButton(
                child: Text(
                  KeyLanguage.cancel.tr,
                  style: Theme.of(context).textTheme.headline4,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  KeyLanguage.cancel.tr,
                  style: Theme.of(context).textTheme.headline4,
                ),
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
                child: Text(KeyLanguage.cancel.tr),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text(KeyLanguage.setting.tr),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
            ],
          );
  }
}
