import 'package:achitecture_weup/common/core/widget/ink_well_comp.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RadioCustomComp<T> extends StatelessWidget {
  final T value;
  late T groupValue;
  final Function(T? value) onChanged;
  final Widget widgetDefault, widgetSelected;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;
  final double scaleEnd;
  final double scaleBegin;
  final int duration;

  RadioCustomComp({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    required this.widgetDefault,
    required this.widgetSelected,
    this.transitionBuilder,
    this.scaleEnd = 1,
    this.scaleBegin = 3.5,
    this.duration = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      isTransparent: true,
      paddingAll: 0,
      onTap: () {
        if (groupValue != value) {
          onChanged(value);
        }
      },
      child: AnimatedSwitcher(
        duration:  Duration(milliseconds:  duration ),
        reverseDuration: const Duration(microseconds: 500),
        transitionBuilder: transitionBuilder ??
            (child, anim) => child.key == const ValueKey('widgetSelected')
                ? ScaleTransition(
                    scale: Tween<double>(begin: scaleBegin, end: scaleEnd).animate(anim),
                    child: scaleEnd == 1
                        ? ScaleTransition(
                            scale: anim,
                            child: child,
                          )
                        : FadeTransition(
                            opacity: anim,
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
