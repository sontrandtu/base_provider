import 'package:achitech_weup/common/resource/color_resource.dart';
import 'package:achitech_weup/common/resource/enum_resource.dart';

import 'package:flutter/material.dart';

class OutlinedButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Status? status;
  final FontWeight? titleFontWeight;
  final double? titleSize;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final Color? titleColor;
  final Color? colorBorder;

  const OutlinedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.titleColor,
    this.style,
    this.titleSize,
    this.titleFontWeight,
    this.widthValue,
    this.heightValue,
    this.onPressed,
    this.padding,
    this.status,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor, this.colorBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: OutlinedButton(
        onPressed: status != Status.waiting ? onPressed : null,
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
        style: buttonStyle ??
            OutlinedButton.styleFrom(
              side:
                  BorderSide(color: colorBorder?? ColorResource.primarySwatch),
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
            ),
      ),
    );
  }
}
