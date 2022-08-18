import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_config/permission_config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translator/translator.dart';

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
            title: Text(KeyLanguage.camera.tr),
            onTap: () async {
              bool checkPermission = await PermissionConfig.instance.request(
                context,
                permission: Permission.camera,
                title: KeyLanguage.camera.tr,
                content: KeyLanguage.questionCamera.tr,
              );
              if (checkPermission) {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
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
            title: Text(KeyLanguage.imageGallery.tr),
            onTap: () async {
              bool checkPermission = await PermissionConfig.instance.request(
                context,
                permission: Permission.photos,
                title: KeyLanguage.imageGallery.tr,
                content: KeyLanguage.questionImageGallery.tr,
              );
              if (checkPermission) {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
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
