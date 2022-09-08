import 'package:flutter/material.dart';

class OutlinedButtonComp extends StatelessWidget {
  final dynamic title;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final bool? isEnable;
  final double? borderRadius;
  final double? width;
  final double? height;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final Color? colorBorder;

  const OutlinedButtonComp({
    Key? key,
    this.title,
    this.style,
    this.width,
    this.height,
    this.onPressed,
    this.padding,
    this.isEnable = true,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.colorBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isEnable! ? onPressed : null,
        child: title is Widget
            ? title
            : Text(
                title ?? '',
                style: style ?? Theme.of(context).textTheme.headline4,
              ),
        style: buttonStyle ??
            OutlinedButton.styleFrom(
              foregroundColor: primaryColor, padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              side: BorderSide(color: colorBorder ?? Theme.of(context).primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 4),
              ),
            ),
      ),
    );
  }
}
