import 'package:achitecture_weup/common/resource/color/external_color.dart';
import 'package:flutter/material.dart';

BaseColor ColorResource = BaseColor();

extension ColorExtension on String? {
  Color get parse {
    return Color(int.parse(colors[this]!.replaceAll('#', '0xFF')));
  }
}

class BaseColor {
  Color primary = const Color(0xFF0A1F72);
  Color secondPrimary = const Color(0xFFFF6700);

  Color textBody = const Color(0xFF666666);

  Color divider = const Color(0xFFEFEFEF);

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

  MaterialColor customMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
