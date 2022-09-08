import 'package:flutter/material.dart';
import 'package:theme/src/key_color.dart';
import 'package:theme/src/utils/utils.dart';

import 'external_color.dart';

extension ColorExtension on String? {
  Color get parse {
    if (!json[this].toString().startsWith('#')) throw Exception('Hex ($this) not start with \'#\'');

    return Color(int.parse(json[this]!.replaceAll('#', '0xFF')));
  }
}

class BaseColor {
  Color primary = KeyColor.primary.parse;

  Color secondPrimary = KeyColor.secondPrimary.parse;

  Color textBody = KeyColor.textBody.parse;

  Color divider = KeyColor.divider.parse;

  Color backgroundColor = Colors.white;

  late MaterialColor primarySwatchMaterial;

  late Color colorSplash;

  late Color colorHighLight;

  BaseColor() {
    init();
  }

  void init() {
    primarySwatchMaterial = Utils.getMaterialColor(primary);
    colorSplash = primarySwatchMaterial.withAlpha(100);
    colorHighLight = primarySwatchMaterial.withAlpha(50);
  }
}
