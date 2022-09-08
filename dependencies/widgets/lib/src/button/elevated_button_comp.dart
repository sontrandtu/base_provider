import 'package:flutter/material.dart';

class ElevatedButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final bool? isEnable;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final double? elevation;

  const ElevatedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.onPressed,
    this.isEnable = true,
    this.padding,
    this.style,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.widthValue,
    this.heightValue,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: ElevatedButton(
        onPressed: isEnable! ? onPressed : null,
        child: child ??
            Text(title ?? '',
                style: style ?? Theme.of(context).textTheme.headline4?.apply(color: Colors.white)),
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12), backgroundColor: (primaryColor ?? Colors.blue).withOpacity(!isEnable! ? 0.5 : 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
              elevation: elevation,
            ),
      ),
    );
  }
}
