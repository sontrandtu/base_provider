
import 'package:achitecture_weup/common/core/theme/theme_manager.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
//
// class ElevatedButtonComp extends StatefulWidget {
//   final String? title;
//   final Widget? child;
//   final Function()? onPressed;
//   final EdgeInsetsGeometry? padding;
//   final TextStyle? style;
//   final Status? status;
//   final double? borderRadius;
//   final double? widthValue;
//   final double? heightValue;
//   final ButtonStyle? buttonStyle;
//   final Color? primaryColor;
//   final double? elevation;
//
//   const ElevatedButtonComp(
//       {Key? key,
//       this.title,
//       this.child,
//       required this.onPressed,
//       this.padding,
//       this.style,
//       this.status,
//       this.borderRadius,
//       this.widthValue,
//       this.heightValue,
//       this.buttonStyle,
//       this.primaryColor,
//       this.elevation})
//       : super(key: key);
//
//   @override
//   State<ElevatedButtonComp> createState() => _ElevatedButtonCompState();
// }
//
// class _ElevatedButtonCompState extends State<ElevatedButtonComp>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> animation;
//   bool tap = false;
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//       vsync: this,
//       lowerBound: 0.0,
//       upperBound: 1.0,
//       duration: const Duration(milliseconds: 200),
//     );
//     animationController.value = 1;
//     animation = Tween(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.elasticOut,
//       ),
//     );
//     super.initState();
//   }
//
//   void _pressed(_) {
//     log('tap');
//     setState(() {
//       tap = true;
//     });
//   }
//
//   void _unPressedOnTapUp(_) => _unPressed();
//
//   void _unPressed() {
//     setState(() {
//       tap = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: _pressed,
//       onTapUp: _unPressedOnTapUp,
//       onTapCancel: _unPressed,
//       child: AnimatedScale(
//         duration: const Duration(milliseconds: 100),
//         scale: tap ? 0.8 : 1.0,
//         child: SizedBox(
//           width: widget.widthValue,
//           height: widget.heightValue,
//           child: ElevatedButton(
//             onPressed: null,
//             child: widget.child ??
//                 Text(widget.title ?? '',
//                     style: widget.style ??
//                         appStyle.textTheme.headline4
//                             ?.apply(color: Colors.white)),
//             style: widget.buttonStyle ??
//                 ElevatedButton.styleFrom(
//                   padding: widget.padding ??
//                       const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                   primary: (widget.primaryColor ??
//                           ColorResource.primarySwatchMaterial)
//                       .withOpacity(widget.status == Status.waiting ? 0.5 : 1),
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.circular(widget.borderRadius ?? 0),
//                   ),
//                   elevation: widget.elevation,
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ElevatedButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Status? status;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final double? elevation;

  const ElevatedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.onPressed,
    this.status,
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
        onPressed: status != Status.waiting ? onPressed : null,
        child: child ??
            Text(title ?? '',
                style: style ??
                    appStyle.textTheme.headline4?.apply(color: Colors.white)),
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              primary: (primaryColor ?? ColorResource.primarySwatchMaterial)
                  .withOpacity(status == Status.waiting ? 0.5 : 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
              elevation: elevation,
            ),
      ),
    );
  }
}
