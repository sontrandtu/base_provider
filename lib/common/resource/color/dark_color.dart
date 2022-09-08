
import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:flutter/material.dart';

class DarkColor extends BaseColor {
  @override
  Color get divider => Colors.black;

  @override
  Color get primary => const Color(0xFFFF6700);

  @override
  Color get secondPrimary => const Color(0xFF0A1F72);

  @override
  Color get textBody => Colors.white;

  @override
  Color get backgroundColor => Colors.black;
}
