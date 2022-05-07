import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TypeImageViewer {
  assets,
  storage
}

class ImageViewer extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit? boxFit;
  final Color? color;
  final TypeImageViewer type;

  const ImageViewer({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.borderRadius,
    this.padding,
    this.boxFit,
    this.color,
    this.type = TypeImageViewer.assets,
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
        child: type == TypeImageViewer.assets ? Image.asset(
          url,
          fit: boxFit ?? BoxFit.contain,
        ) : Image.file(
          File(url),
          fit: boxFit ?? BoxFit.contain,
        ),
      ),
    );
  }
}
