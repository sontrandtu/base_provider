import 'package:achitecture_weup/common/helper/custom_material_color.dart';
import 'package:achitecture_weup/common/resource/color/external_color.dart';
import 'package:flutter/material.dart';

BaseColor ColorResource = BaseColor();

extension ColorExtension on String? {
  Color get parse {
    return Color(int.parse(colors[this]!.replaceAll('#', '0xFF')));
  }
}

class BaseColor {
  Color primary = Color(0xFF0A1F72);
  Color secondPrimary = Color(0xFFFF6700);

  Color textBody = Color(0xFF666666);

  Color divider = Color(0xFFEFEFEF);

  Color backgroundColor = Colors.white;

  late MaterialColor primarySwatchMaterial;

  late Color colorSplash;

  late Color colorHighLight;

  BaseColor() {
    init();
  }

  void init() {
    primarySwatchMaterial = customMaterialColor(primary);
    colorSplash = primarySwatchMaterial.withAlpha(100);
    colorHighLight = primarySwatchMaterial.withAlpha(50);
  }
}
