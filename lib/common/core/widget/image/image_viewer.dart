import 'dart:io';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TypeImageViewer { assets, storage, network }

class ImageViewer extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit? boxFit;
  final Color? color;

  const ImageViewer(
    this.url, {
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.boxFit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TypeImageViewer type = TypeImageViewer.assets;
    RegExp regExp = RegExp(r'^\/(storage|data)[^\.]', multiLine: true);
    if (regExp.hasMatch(url)) {
      type = TypeImageViewer.storage;
    } else if (url.isValidUrl) {
      type = TypeImageViewer.network;
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(color: color),
        child: _imgWidget(type),
      ),
    );
  }

  Widget _imgWidget(TypeImageViewer type) {
    if (type == TypeImageViewer.network) {
      return Image.network(
        url,
        fit: boxFit ?? BoxFit.contain,
      );
    } else if (type == TypeImageViewer.storage) {
      return Image.file(
        File(url),
        fit: boxFit ?? BoxFit.contain,
      );
    } else {
      return Image.asset(
        url,
        fit: boxFit ?? BoxFit.contain,
      );
    }
  }
}
