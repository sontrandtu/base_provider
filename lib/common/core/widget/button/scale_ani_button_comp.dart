import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

class ScaleAniButtonComp extends StatefulWidget {
  final Function() onPressed;
  final bool enabled;
  final Widget child;
  final Color color;
  final double borderRadius;
  final int duration;
  final double elevation;
  final EdgeInsetsGeometry? padding;
  final bool isElevation;

  const ScaleAniButtonComp({
    Key? key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.color = Colors.blue,
    this.duration = 100,
    this.borderRadius = 16,
    this.elevation = 4,
    this.padding, this.isElevation=true,
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
    widget.onPressed;
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {
    setState(() {
      tap = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedScale(
        scale: tap ? 0.8 : 1,
        duration: Duration(milliseconds: widget.duration),
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: widget.isElevation ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
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
