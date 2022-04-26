import 'package:achitecture_weup/common/core/widget/ink_well_comp.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class CheckBoxCustomComp extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  final Widget widgetDefault, widgetSelected;
  final AnimatedSwitcherTransitionBuilder? transitionBuilder;

  const CheckBoxCustomComp({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.widgetDefault,
    required this.widgetSelected,
    this.transitionBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      isTransparent: true,
      onTap: () => onChanged(value),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) => ScaleTransition(
          scale: anim,
          child: child,
        ),
        child: value
            ? Container(
                key: const ValueKey('widget1'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorResource.primarySwatch,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.male_rounded,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                key: const ValueKey('widget2'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.male_rounded,
                    color: Colors.blue,
                  ),
                ),
              ),
      ),
    );
  }
}
