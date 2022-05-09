import 'dart:developer';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';

class ScaleAniButtonComp extends StatefulWidget {
  final GestureTapCallback onPressed;
  final bool enabled;
  final bool isElevation;
  final Widget child;
  final Color color;
  final double borderRadius;
  final double elevation;
  final double scaleBegin, scaleEnd;
  final double? width, height;
  final int duration;
  final EdgeInsetsGeometry? padding;

  const ScaleAniButtonComp({
    Key? key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.color = Colors.blue,
    this.duration = 1000,
    this.borderRadius = 16,
    this.elevation = 4,
    this.padding,
    this.isElevation = true,
    this.scaleBegin = 0.8,
    this.scaleEnd = 1,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<ScaleAniButtonComp> createState() => _ScaleAniButtonCompState();
}

class _ScaleAniButtonCompState extends State<ScaleAniButtonComp>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      value: 1,
    );

    animation = Tween(
      begin: widget.scaleBegin,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _pressed(_) {
    animationController.value = 0;
  }

  void _unPressedOnTapUp(_) {
    animationController.forward();
  }

  Future<void> _unPressed() async {
    animationController.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? cachedChild) {
          return Transform.scale(
            scale: animation.value,
            child: widget.child
          );
        },
      ),
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
    );
  }
}
