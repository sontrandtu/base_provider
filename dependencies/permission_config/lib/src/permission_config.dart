import 'package:flutter/material.dart';
import 'package:permission_config/src/permission_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionConfig {
  PermissionConfig._internal();

  static final PermissionConfig  _instance = PermissionConfig._internal();

  factory PermissionConfig()=> _instance;

  // Yêu cầu 1 quyền
  Future<bool> request(
    BuildContext context, {
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
        showDialog(context: context, builder: (context) => PermissionDialog(title: title, content: content));
        return false;
    }
  }

  // Yêu cầu nhiều quyền
  Future<bool> requests(BuildContext context, List<Permission> permissions) async {
    List<String> _requestTitle = [];
    final Map<Permission, PermissionStatus> status = await permissions.request();
    bool _result = true;
    await Future.forEach(status.entries, (MapEntry element) {
      if (element.value != PermissionStatus.granted) {
        _requestTitle.add(_getRequestTitle(element.key));
        _result = false;
      }
    }).then((value) {
      if (_requestTitle.isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) => PermissionDialog(
                title: 'Thông báo',
                content: 'Bạn cần cấp quyền truy cập ${_requestTitle.join(', ')} để tiếp tục'));
      }
    });
    return _result;
  }

  String _getRequestTitle(Permission permission) {
    switch (permission.toString()) {
      case 'Permission.storage':
        return 'Bộ nhớ';
      case 'Permission.camera':
        return 'Camera';
      case 'Permission.notification':
        return 'Thông báo';
      case 'Permission.location':
        return 'Vị trí';
      case 'Permission.phone':
        return 'Danh bạ';
      case 'Permission.photos':
        return 'Thư viện';
      case 'Permission.microphone':
        return 'Microphone';
      default:
        return '';
    }
  }
}
