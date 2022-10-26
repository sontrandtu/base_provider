import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComp extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final int? milliseconds, loop;
  final ShimmerDirection? direction;
  final bool? enabled;

  const ShimmerComp({
    Key? key,
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    this.milliseconds,
    this.direction,
    this.enabled,
    this.loop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: Duration(milliseconds: milliseconds ?? 1500),
      direction: direction ?? ShimmerDirection.ltr,
      enabled: enabled ?? true,
      loop: loop ?? 0,
    );
  }
}
