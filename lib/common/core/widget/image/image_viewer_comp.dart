import 'dart:io';

import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../helper/system_utils.dart';
import 'cached_network_image_comp.dart';
import 'svg_comp.dart';
import 'view_image.dart';


enum TypeImageViewer { none, assets, storage, network, svg }

class ImageViewer extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit fit;
  final Color? color;
  final bool hasViewImage;
  final Widget? defaultImg;
  final Widget? placeHolder;
  final Color? backgroundColor;
  final double? borderWidth;
  final Color? borderColor;
  final List<String>? urls;
  final int? index;

  const ImageViewer(
      this.url, {
        Key? key,
        this.width,
        this.height,
        this.borderRadius,
        this.placeHolder,
        this.defaultImg,
        this.padding,
        this.fit = BoxFit.contain,
        this.color,
        this.hasViewImage = false,
        this.backgroundColor,
        this.borderWidth,
        this.borderColor,
        this.urls,
        this.index,
      }) : super(key: key);

  TypeImageViewer get type {
    if (url.isStorage()) {
      return TypeImageViewer.storage;
    } else if (url.isValidUrl) {
      return TypeImageViewer.network;
    } else if (url.isAssetsPng()) {
      return TypeImageViewer.assets;
    } else if (url.isAssetsSvg()) {
      return TypeImageViewer.svg;
    }
    return TypeImageViewer.none;
  }

  @override
  Widget build(BuildContext context) {
    if (systemIsEmpty(url) || type == TypeImageViewer.none) return defaultImg ?? const SizedBox();
    return InkWell(
      onTap: hasViewImage ? () => _onTap(context) : null,
      // onLongPress: ,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(color: color),
          child: _imageWidget(),
        ),
      ),
    );
  }

  Widget _imageWidget() {
    switch (type) {
      case TypeImageViewer.network:
        return CachedNetworkImageComp(
          url: url,
          fit: fit,
          borderColor: borderColor ?? Colors.transparent,
          borderWidth: borderWidth ?? 0,
          borderRadius: borderRadius,
          width: width,
          height: height,
          widgetError: defaultImg,
          widgetPlaceHolder: placeHolder,
          backgroundColor: backgroundColor,
        );
      case TypeImageViewer.storage:
        return Image.file(File(url), fit: fit, color: color);
      case TypeImageViewer.svg:
        return SvgComp(
          url: url,
          width: width,
          height: height,
          borderRadius: borderRadius,
          color: color,
        );
      default:
        return Image.asset(url, fit: fit);
    }
  }

  Future<void> _onTap(BuildContext context) async {
    // if (!await _checkNetWorkImage(url)) return;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ViewImage(ImageData(urls: urls ?? [url], index: index ?? 0))));
  }

  // Future<bool> _checkNetWorkImage(String? url) async {
  //   try {
  //     var response = await Dio().get(url ?? '');
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
