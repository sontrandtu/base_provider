import 'package:flutter/material.dart';

class ElevatedButtonComp extends StatelessWidget {
  final dynamic title;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final double? height;
  final bool? isEnable;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final double? elevation;

  const ElevatedButtonComp({
    Key? key,
    this.title,
    this.onPressed,
    this.isEnable = true,
    this.padding,
    this.style,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.width,
    this.height,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnable! ? onPressed : null,
        child: title is Widget ? title : Text(title ?? ''),
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              backgroundColor: (primaryColor ?? Colors.blue).withOpacity(!isEnable! ? 0.5 : 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
              elevation: elevation,
            ),
      ),
    );
  }
}
