import 'package:flutter/material.dart';

class PositionAniButtonComp extends StatefulWidget {
  final GestureTapCallback onPressed;
  final bool enabled;
  final Widget child;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final int duration;
  final ShadowDegree shadowDegree;

  const PositionAniButtonComp({
    Key? key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.color = Colors.blue,
    this.height = 60,
    this.width = 160,
    this.shadowDegree = ShadowDegree.light,
    this.duration = 70,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  State<PositionAniButtonComp> createState() => _PositionAniButtonCompState();
}

class _PositionAniButtonCompState extends State<PositionAniButtonComp> {
  bool tap = false;

  void _pressed(_) {
    setState(() {
      tap = true;
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  Future<void> _unPressed() async {
    setState(() {
      tap = false;
    });
    await Future.delayed(const Duration(milliseconds: 50));
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.height - 4;
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                height: height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? darken(widget.color, widget.shadowDegree)
                      : darken(Colors.grey, widget.shadowDegree),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: widget.duration),
              bottom: tap ? 0 : 4,
              child: Container(
                height: height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.enabled ? widget.color : Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Center(
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
    );
  }

  Color darken(Color color, ShadowDegree degree) {
    double amount = degree == ShadowDegree.dark ? 0.2 : 0.12;
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

enum ShadowDegree { light, dark }
