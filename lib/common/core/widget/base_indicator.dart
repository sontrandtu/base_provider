import 'dart:io';

import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseIndicator extends StatelessWidget {
  const BaseIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: 4,
    //   width: MediaQuery.of(context).size.width,
    //   child: LinearProgressIndicator(
    //       minHeight: 4,
    //       color: ColorResource.primary,
    //       backgroundColor: ColorResource.primary.withOpacity(0.5)),
    // );
    return Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator(color: ColorResource.primary)
            : const CupertinoActivityIndicator());
  }
}
