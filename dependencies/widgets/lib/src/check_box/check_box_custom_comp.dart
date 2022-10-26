import 'package:flutter/material.dart';
import 'package:widgets/src/button/ink_well_comp.dart';

// ignore: must_be_immutable
// class CheckBoxCustomComp extends StatefulWidget {
//   bool value;
//   final Function(bool? value) onChanged;
//   final Widget widgetDefault, widgetSelected;
//   final AnimatedSwitcherTransitionBuilder? transitionBuilder;
//
//   CheckBoxCustomComp({
//     Key? key,
//     required this.value,
//     required this.onChanged,
//     required this.widgetDefault,
//     required this.widgetSelected,
//     this.transitionBuilder,
//   }) : super(key: key);
//
//   @override
//   State<CheckBoxCustomComp> createState() => _CheckBoxCustomCompState();
// }
//
// class _CheckBoxCustomCompState extends State<CheckBoxCustomComp> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           widget.value = !widget.value;
//         });
//         widget.onChanged(!widget.value);
//       },
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 200),
//         child: widget.value
//             ? Container(
//                 key: const ValueKey('widgetSelected'),
//                 child: widget.widgetSelected,
//               )
//             : Container(
//                 key: const ValueKey('widgetDefault'),
//                 child: widget.widgetDefault,
//               ),
//       ),
//     );
//   }
// }

class CheckBoxCustomComp extends StatelessWidget {
  final bool value;
  final Function(bool value) onChanged;
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
      onTap: () => onChanged(!value),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchOutCurve: Curves.bounceOut,
        switchInCurve: Curves.bounceIn,
        transitionBuilder: transitionBuilder ??
            (child, anim) => FadeTransition(
                  opacity: anim,
                  child: child,
                ),
        child: value
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
