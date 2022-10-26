import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IndicatorComp extends StatelessWidget {
  const IndicatorComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(kIsWeb) return CircularProgressIndicator(color: Theme.of(context).primaryColor);
    return Platform.isIOS
        ? CupertinoActivityIndicator(color: Theme.of(context).primaryColor)
        : CircularProgressIndicator(color: Theme.of(context).primaryColor);
  }
}
