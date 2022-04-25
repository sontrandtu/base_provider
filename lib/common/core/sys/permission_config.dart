import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/core/widget/dialog/permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionConfig {
  PermissionConfig._internal();

  static PermissionConfig get instance => PermissionConfig._internal();

  Future<bool> requestPermission({
    required Permission permission,
    required String title,
    required String content,
  }) async {
    final status = await permission.request();
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        return true;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.permanentlyDenied:
        showDialog(
            context: navigator.currentContext!,
            builder: (context) =>
                PermissionDialog(title: title, content: content));
        return false;
    }
  }
}
