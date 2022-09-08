import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_utils/image_picker_utils.dart';
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
              final pickedImage =
                  await ImageManager.builder().setSource(PickSource.camera).hasCompress().single();
              Navigator.pop(context, pickedImage);
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
            title: Text(KeyLanguage.imageGallery.tr),
            onTap: () async {
              final pickedImage =
                  await ImageManager.builder().setSource(PickSource.gallery).hasCompress().single();
              Navigator.pop(context, pickedImage);
            },
          ),
        ],
      ),
    );
  }
}
