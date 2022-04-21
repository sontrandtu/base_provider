import 'dart:io';

import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorComp extends StatelessWidget {
  const IndicatorComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResource.textBody.withOpacity(0.05),
      child: Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator(color: ColorResource.primary)
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}
