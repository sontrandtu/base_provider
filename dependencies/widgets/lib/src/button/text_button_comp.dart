import 'package:flutter/material.dart';

class TextButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final bool? isEnable;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;

  const TextButtonComp({
    Key? key,
    this.title,
    this.child,
    this.style,
    this.widthValue,
    this.heightValue,
    this.onPressed,
    this.padding,
    this.isEnable = true,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: TextButton(
        onPressed: isEnable! ? onPressed : null,
        child: child ??
            Text(
              title ?? '',
              style: style ?? Theme.of(context).textTheme.headline4,
            ),
        style: buttonStyle ??
            TextButton.styleFrom(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              primary: primaryColor,
              textStyle: style ?? Theme.of(context).textTheme.headline4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
            ),
      ),
    );
  }
}
