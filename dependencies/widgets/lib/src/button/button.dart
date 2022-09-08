import 'package:flutter/material.dart';
import 'package:widgets/src/button/elevated_button_comp.dart';
import 'package:widgets/src/button/outlined_button_comp.dart';
import 'package:widgets/src/button/text_button_comp.dart';

enum ButtonStyle { text, outline, custom, solid }

class Button extends StatelessWidget {
  const Button.custom(
      {Key? key,
      this.buttonStyle,
      this.title,
      this.child,
      this.onPressed,
      this.padding,
      this.style,
      this.isEnable,
      this.borderRadius,
      this.widthValue,
      this.heightValue,
      this.primaryColor})
      : super(key: key);

  const Button.text(
      {Key? key,
      this.title,
      this.child,
      this.onPressed,
      this.padding,
      this.isEnable,
      this.borderRadius,
      this.widthValue,
      this.heightValue,
      this.style,
      this.primaryColor})
      : buttonStyle = ButtonStyle.text,
        super(key: key);

  const Button.outlined(
      {Key? key,
      this.title,
      this.child,
      this.onPressed,
      this.padding,
      this.style,
      this.isEnable,
      this.borderRadius,
      this.widthValue,
      this.heightValue,
      this.primaryColor})
      : buttonStyle = ButtonStyle.outline,
        super(key: key);

  const Button.solid(
      {Key? key,
      this.title,
      this.child,
      this.onPressed,
      this.padding,
      this.style,
      this.isEnable,
      this.borderRadius,
      this.widthValue,
      this.heightValue,
      this.primaryColor})
      : buttonStyle = ButtonStyle.solid,
        super(key: key);

  final ButtonStyle? buttonStyle;

  final String? title;
  final Widget? child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final bool? isEnable;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    switch (buttonStyle) {
      case ButtonStyle.text:
        return TextButtonComp();
      case ButtonStyle.outline:
        return OutlinedButtonComp();
      case ButtonStyle.solid:
        return ElevatedButtonComp();
    }
    return SizedBox();
  }
}
