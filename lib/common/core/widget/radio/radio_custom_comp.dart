import 'package:achitecture_weup/common/core/widget/ink_well_comp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioCustomComp<T> extends StatelessWidget {
  final T value;
  late T groupValue;
  final Function(T? value) onChanged;
  final Widget widgetDefault, widgetSelected;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;
  final double? scaleEnd;

  RadioCustomComp({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    required this.widgetDefault,
    required this.widgetSelected,
    this.transitionBuilder,
    this.scaleEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      isTransparent: true,
      paddingAll: 0,
      onTap: () => onChanged(value),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: transitionBuilder ??
            (child, anim) => child.key == const ValueKey('widgetSelected')
                ? ScaleTransition(
                    scale: Tween<double>(begin: 1, end: scaleEnd ?? 1)
                        .animate(anim),
                    child: ScaleTransition(
                      scale: anim,
                      child: child,
                    ),
                  )
                : FadeTransition(
                    opacity: anim,
                    child: child,
                  ),
        child: groupValue == value
            ? Container(
                key: const ValueKey('widgetSelected'),
                child: widgetSelected,
              )
            : Container(
                key: const ValueKey('widgetDefault'),
                child: widgetDefault,
              ),
      ),
    );
  }
}
