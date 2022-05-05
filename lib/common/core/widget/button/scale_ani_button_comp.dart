import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';

class ScaleAniButtonComp extends StatefulWidget {
  final GestureTapCallback onPressed;
  final bool enabled;
  final Widget child;
  final Color color;
  final double borderRadius;
  final int duration;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final bool isElevation;
  final double scaleBegin, scaleEnd;

  const ScaleAniButtonComp({
    Key? key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.color = Colors.blue,
    this.duration = 70,
    this.borderRadius = 16,
    this.elevation = 4,
    this.padding,
    this.isElevation = true,
    this.scaleBegin = 0.8,
    this.scaleEnd = 1,
  }) : super(key: key);

  @override
  State<ScaleAniButtonComp> createState() => _ScaleAniButtonCompState();
}

class _ScaleAniButtonCompState extends State<ScaleAniButtonComp> {
  bool tap = false;

  void _pressed(_) {
    setState(() {
      tap = true;
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  Future<void> _unPressed()  async {
    setState(() {
      tap = false;
    });
    await Future.delayed(const Duration(milliseconds: 70));
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedScale(
        curve:Curves.easeIn,
        scale: tap ? widget.scaleBegin : widget.scaleEnd,
        duration: Duration(milliseconds: widget.duration),
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: widget.isElevation
                ? [
                    BoxShadow(
                      color: appStyle.shadowColor.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: widget.child,
        ),
      ),
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
    );
  }
}
