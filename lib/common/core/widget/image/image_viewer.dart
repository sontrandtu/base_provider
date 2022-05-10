import 'dart:io';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/extension/object_ext.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
part 'view_detail_image.dart';

enum TypeImageViewer { assets, storage, network }

class ImageViewer extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit fit;
  final Color? color;
  final bool hasViewImage;
  final String? title;

  const ImageViewer(
    this.url, {
    Key? key,
    this.width = 100,
    this.height = 100,
    this.borderRadius,
    this.padding,
    this.fit = BoxFit.contain,
    this.color,
    this.hasViewImage = false,
    this.title,
  }) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late TypeImageViewer type;

  @override
  void initState() {
    RegExp regExp = RegExp(r'^\/(storage|data)[^\.]');
    if (regExp.hasMatch(widget.url)) {
      type = TypeImageViewer.storage;
    } else if (widget.url.isValidUrl) {
      type = TypeImageViewer.network;
    } else {
      type = TypeImageViewer.assets;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.url.isNotNullBlank) return const SizedBox.shrink();
    return InkWellComp(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(color: widget.color),
          child: _ImageWidget(
            widget.url,
            type: type,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
          ),
        ),
      ),
    );
  }

  void onTap() {
    if (!widget.hasViewImage) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => _ViewImage(widget.url, type: type)));
  }
}

class _ImageWidget extends StatelessWidget {
  final String url;
  final TypeImageViewer type;
  final double width;
  final double height;
  final BoxFit fit;

  const _ImageWidget(
    this.url, {
    Key? key,
    required this.type,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == TypeImageViewer.network) {
      return CachedNetworkImageComp(
        url: url,
        width: width,
        height: height,
        fit: fit,
      );
    } else if (type == TypeImageViewer.storage) {
      return Image.file(
        File(url),
        fit: fit,
        height: height,
        width: width,
      );
    }
    return Image.asset(
      url,
      fit: fit,
      height: height,
      width: width,
    );
  }
}