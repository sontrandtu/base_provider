import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class SwitchComp extends StatelessWidget {
  final bool? value;
  final Function(bool value)? onChanged;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final Color? activeTrackColor;

  const SwitchComp({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeTrackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value ?? false,
      onChanged: onChanged,
      activeColor: activeColor ?? ColorResource.primarySwatch,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      activeTrackColor: activeTrackColor,
    );
  }
}
