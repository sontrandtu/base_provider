import 'package:achitecture_weup/common/core/theme/theme_manager.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class BaseErrorDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? textButtonConfirm;
  final String? textButtonCancel;
  final bool? showConfirm;
  final bool? showCancel;
  final Function? mConfirm;
  final Function? mCancel;

  const BaseErrorDialog(
      {Key? key,
      this.title,
      this.mConfirm,
      this.mCancel,
      this.showCancel,
      this.showConfirm,
      this.content,
      this.textButtonCancel,
      this.textButtonConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(title ?? 'Thông báo',
            style: appStyle.textTheme.headline3?.apply(color: ColorResource.primary)),
        content: Text(content ?? '', style: appStyle.textTheme.bodyText1),
        insetPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        actions: [
          showConfirm ?? true
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    mConfirm?.call();
                  },
                  child: Text(
                    textButtonConfirm ?? 'Đồng ý',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                )
              : const SizedBox(),
          showCancel ?? true
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    mCancel?.call();
                  },
                  child: Text(
                    textButtonCancel ?? 'Hủy',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
