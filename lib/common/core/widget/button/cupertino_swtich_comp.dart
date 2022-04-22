import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSwitchComp extends StatelessWidget {
  final bool? value;
  final Function(bool value)? onChanged;
  final Color? activeColor;
  final Color? thumbColor;
  final Color? trackColor;

  const CupertinoSwitchComp({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.thumbColor,
    this.trackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: value ?? false,
      onChanged: onChanged,
      activeColor: activeColor ?? ColorResource.primarySwatch,
      thumbColor: thumbColor,
      trackColor: trackColor,
    );
  }
}
