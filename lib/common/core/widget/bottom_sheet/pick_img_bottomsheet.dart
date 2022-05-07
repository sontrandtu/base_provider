import 'package:achitecture_weup/common/core/sys/permission_config.dart';
import 'package:achitecture_weup/common/extension/app_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImgBottomSheetDialog extends StatelessWidget {
  const PickImgBottomSheetDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.camera_fill),
            title: Text(KeyLanguage.camera.tl),
            onTap: () async {
              bool checkPermission =
                  await PermissionConfig.instance.requestPermission(
                permission: Permission.camera,
                title: KeyLanguage.camera.tl,
                content: KeyLanguage.questionCamera.tl,
              );
              if (checkPermission) {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  Navigator.pop(context, pickedImage.path);
                } else {
                  Navigator.pop(context);
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
            title: Text(KeyLanguage.imageGallery.tl),
            onTap: () async {
              bool checkPermission =
                  await PermissionConfig.instance.requestPermission(
                permission: Permission.photos,
                title: KeyLanguage.imageGallery.tl,
                content: KeyLanguage.questionImageGallery.tl,
              );
              if (checkPermission) {
                final pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  Navigator.pop(context, pickedImage.path);
                } else {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
