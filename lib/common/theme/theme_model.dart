import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:flutter/material.dart';

class ThemeModel {
  int? id;
  ThemeData? data;
  BaseColor? color;

  ThemeModel({this.id, this.data, this.color}) {
    init();
  }

  @override
  String toString() {
    return 'id: $id, data: $data, color: $color';
  }

  void init() {
    data = data?.copyWith(
        primaryColor: color?.primary,
        indicatorColor: color?.primary,
        toggleableActiveColor: color?.primary,
        splashColor: color?.colorSplash,
        highlightColor: color?.colorHighLight,
        dividerColor: color?.divider,
        backgroundColor: color?.backgroundColor,
        scaffoldBackgroundColor: color?.backgroundColor,
        textTheme: data?.textTheme.apply(bodyColor: color?.textBody),
);
  }
}
