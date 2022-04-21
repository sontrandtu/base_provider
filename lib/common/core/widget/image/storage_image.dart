import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StorageImageComp extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit? boxFit;
  final Color? color;

  const StorageImageComp({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius,
    this.padding,
    this.boxFit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(color: color),
        child: Image.file(
          File(url),
          fit: boxFit ?? BoxFit.contain,
        ),
      ),
    );
  }
}
