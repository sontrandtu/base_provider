import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ElevatedButtonComp extends StatelessWidget {
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

  const ElevatedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.onPressed,
    this.status,
    this.padding,
    this.titleColor,
    this.style,
    this.titleSize,
    this.titleFontWeight,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.widthValue,
    this.heightValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: ElevatedButton(
        onPressed: status != Status.waiting ? onPressed : null,
        child: child ??
            Text(title ?? '',
                style: style ??
                    appStyle.textTheme.headline4?.apply(color: Colors.white)),
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
              primary: (primaryColor ?? ColorResource.primarySwatchMaterial)
                  .withOpacity(status == Status.waiting ? 0.5 : 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
            ),
      ),
    );
  }
}