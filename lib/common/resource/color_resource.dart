import 'package:achitech_weup/common/helper/custom_material_color.dart';
import 'package:flutter/material.dart';

class ColorResource {
  static const Color primary = Color(0xFF0A1F72);
  static const Color secondPrimary = Color(0xFFFF6700);
  static const Color textBody = Color(0xFF323232);
  static const Color divider = Color(0xFFEFEFEF);
  static MaterialColor primarySwatch= customMaterialColor(const  Color(0xFF0A1F72));
  static  Color colorSplash = primarySwatch.withAlpha(100);
  static  Color colorHighLight= primarySwatch.withAlpha(50);
}
