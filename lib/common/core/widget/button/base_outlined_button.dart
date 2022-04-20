import 'package:achitech_weup/common/resource/color_resource.dart';

import 'package:flutter/material.dart';

class BaseOutlinedButton extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onTab;
  final Color? titleColor;
  final TextStyle? style;
  final double? titleSize;
  final FontWeight? titleFontWeight;
  final double? borderRadiusValue;
  final ButtonStyle? buttonStyleValue;
  final Color? primaryColorValue;
  final double? widthValue;
  final double? heightValue;
  final Color? colorBorderValue;

  const BaseOutlinedButton({
    Key? key,
    this.title,
    this.child,
    this.onTab,
    this.titleColor,
    this.style,
    this.titleSize,
    this.titleFontWeight,
    this.borderRadiusValue,
    this.buttonStyleValue,
    this.primaryColorValue,
    this.widthValue,
    this.heightValue,
    this.colorBorderValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: OutlinedButton(
        onPressed: onTab,
        child: child ??
            Text(
              title ?? '',
              style: style ??
                  TextStyle(
                    color: titleColor,
                    fontSize: titleSize,
                    fontWeight: titleFontWeight,
                  ),
            ),
        style: buttonStyleValue ??
            OutlinedButton.styleFrom(
              side: BorderSide(
                  color: colorBorderValue ?? ColorResource.primary),
              primary: primaryColorValue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusValue ?? 0),
              ),
            ),
      ),
    );
  }
}