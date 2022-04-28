library animated_button;


import 'dart:developer';

import 'package:flutter/material.dart';
//D
class AnimatedButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final bool enabled;
  final BodyAnimated bodyAnimated;//c - A||B

  const AnimatedButton({
    Key? key,
    required this.onPressed,
    this.enabled=true,
    required this.bodyAnimated,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.bodyAnimated,
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
    );
  }

  void _pressed(_) {

    setState(() {
      widget.bodyAnimated.tap = true;
      log('${widget.bodyAnimated.tap}');
    });
    widget.onPressed();
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {
    setState(() {
      widget.bodyAnimated.tap = false;
    });
  }
}

// ignore: must_be_immutable
class BodyAnimated extends StatelessWidget {
  bool tap=false;

  BodyAnimated({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    log('rebuild');
    return Container(child: Text('abc'),);
  }

}

enum ShadowDegree { light, dark }

// ignore: must_be_immutable
class PositionAnimatedButton extends BodyAnimated {
  final Widget? child;
  final bool enabled;
  final Color color;
  final double height;
  final double width;
  final ShadowDegree shadowDegree;
  final int duration;
  final BoxShape shape;

   PositionAnimatedButton({
    Key? key,
    this.child,
    this.enabled = true,
    this.color = Colors.blue,
    this.height = 50,
    this.width = 100,
    this.shadowDegree = ShadowDegree.light,
    this.duration = 100,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  Color darken(Color color, ShadowDegree degree) {
    double amount = degree == ShadowDegree.dark ? 0.2 : 0.12;
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    log('rebuild2 $tap');
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Container(
              height: height - 4,
              width: width,
              decoration: BoxDecoration(
                color: enabled
                    ? darken(color, shadowDegree)
                    : darken(Colors.grey, shadowDegree),
                borderRadius: shape != BoxShape.circle
                    ? const BorderRadius.all(
                  Radius.circular(16),
                )
                    : null,
                shape: shape,
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: duration),
            bottom: tap ? 0 : 4,
            child: Container(
              height: height - 4,
              width: width,
              decoration: BoxDecoration(
                color: enabled ? color : Colors.grey,
                borderRadius: shape != BoxShape.circle
                    ? const BorderRadius.all(
                  Radius.circular(16),
                )
                    : null,
                shape: shape,
              ),
              child: Center(
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
