import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:flutter/material.dart';

import 'key_color.dart';

class ColorResourceImpl extends BaseColor {

  @override
  Color get divider => KeyColor.divider.parse;

  @override
  Color get primary => KeyColor.primary.parse;

  @override
  Color get secondPrimary => KeyColor.secondPrimary.parse;

  @override
  Color get textBody => KeyColor.textBody.parse;
}
