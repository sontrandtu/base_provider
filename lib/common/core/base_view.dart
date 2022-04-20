import 'package:achitech_weup/common/core/widget/base_indicator.dart';
import 'package:achitech_weup/common/resource/enum_resource.dart';
import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  final Status? status;
  final Widget? onSuccess;
  final Widget? onFail;
  final Widget? onLoading;
  final String? title;

  const BaseView({Key? key, this.status, this.onSuccess, this.onFail, this.onLoading, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == Status.error) {
      return Container();
    } else if (status == Status.loading) {
      return onLoading ?? const BaseIndicator();
    }
    return onSuccess ?? Container();
  }
}
