import 'package:flutter/material.dart';

class CheckBoxComp extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final double? scale, splashRadius;
  final bool? tristate, isListTile, isThreeLine;
  final Color? activeColor, checkColor, selectedTileColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? title, secondary, subtitle;

  const CheckBoxComp({
    Key? key,
    required this.value,
    required this.onChanged,
    this.shape,
    this.side,
    this.scale,
    this.tristate,
    this.splashRadius,
    this.activeColor,
    this.checkColor,
    this.isListTile = false,
    this.isThreeLine,
    this.contentPadding,
    this.selectedTileColor,
    this.title,
    this.secondary,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isListTile!
        ? Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              shape: shape,
              side: side,
              tristate: tristate ?? false,
              activeColor: activeColor,
              splashRadius: splashRadius,
              checkColor: checkColor,
            ),
          )
        : CheckboxListTile(
            value: value,
            onChanged: onChanged,
            shape: shape,
            side: side,
            tristate: tristate ?? false,
            activeColor: activeColor,
            title: title,
            contentPadding: contentPadding,
            isThreeLine: isThreeLine ?? false,
            secondary: secondary,
            subtitle: subtitle,
            selectedTileColor: selectedTileColor,
            checkColor: checkColor,
          );
  }
}
