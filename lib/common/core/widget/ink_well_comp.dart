import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class InkWellComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onTab;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? titleFontWeight;
  final EdgeInsetsGeometry? padding;
  final double? paddingAll;

  // BorderRadius.circular(10)
  final double? borderRadiusAll;
  final TextStyle? style;

  final bool? isDotted;
  final Decoration? decorationDotted;

/*  DottedDecoration(
  shape: Shape.box,
  dash: <int>[1, 4],
  borderRadius: BorderRadius.circular(10),
  );*/
  final Border? border;

  const InkWellComp({
    Key? key,
    this.title,
    this.child,
    this.onTab,
    this.backgroundColor,
    this.titleColor,
    this.padding,
    this.borderRadiusAll,
    this.style,
    this.paddingAll,
    this.border,
    this.titleFontWeight,
    this.titleSize,
    this.isDotted = false,
    this.decorationDotted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: border,
      borderRadius: BorderRadius.circular(borderRadiusAll ?? 0),
      child: Container(
        decoration: isDotted!
            ? DottedDecoration(
                shape: Shape.box,
                dash: const <int>[1, 4],
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: InkWell(
          onTap: onTab,
          borderRadius: BorderRadius.circular(borderRadiusAll ?? 0),
          child: Container(
            padding: padding ?? EdgeInsets.all(paddingAll ?? 8),
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
          ),
        ),
      ),
    );
  }
}