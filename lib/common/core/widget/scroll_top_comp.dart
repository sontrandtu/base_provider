import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

class ScrollTopComp extends StatelessWidget {
  final Widget child;

  const ScrollTopComp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollWrapper(
        promptAlignment: Alignment.bottomRight,
        alwaysVisibleAtOffset: true,
        enabledAtOffset: 50,
        builder: (
          BuildContext context,
          ScrollViewProperties properties,
        ) =>
            child);
  }
}
