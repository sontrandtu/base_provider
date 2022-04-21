import 'package:achitech_weup/common/helper/custom_material_color.dart';
import 'package:flutter/material.dart';

class ColorResource {
  static const Color primary = Color(0xFF0A1F72);
  static const Color secondPrimary = Color(0xFFFF6700);

  //static const Color textBody = Color(0xFF0A1F72);
  static const Color divider = Color(0xFFEFEFEF);
  static MaterialColor primarySwatchMaterial =
      customMaterialColor(primarySwatch);
  static const Color primarySwatch = Color(0xFFFAFF46);
  static Color colorSplash = primarySwatchMaterial.withAlpha(100);
  static Color colorHighLight = primarySwatchMaterial.withAlpha(50);
}
