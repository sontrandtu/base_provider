import 'dart:io';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

part 'view_detail_image.dart';

enum TypeImageViewer { none, assets, storage, network }

class ImageViewer extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit fit;
  final Color? color;
  final bool hasViewImage;

  const ImageViewer(
    this.url, {
    Key? key,
    this.width = 70,
    this.height = 70,
    this.borderRadius,
    this.padding,
    this.fit = BoxFit.contain,
    this.color,
    this.hasViewImage = false,
  }) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late TypeImageViewer type;

  @override
  void initState() {
    if (widget.url.isStorage()) {
      type = TypeImageViewer.storage;
    } else if (widget.url.isValidUrl) {
      type = TypeImageViewer.network;
    } else if (widget.url.isAssets()) {
      type = TypeImageViewer.assets;
    } else {
      type = TypeImageViewer.none;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (empty(widget.url) || type == TypeImageViewer.none) return const SizedBox.shrink();
    return InkWellComp(
      onTap: _onTap,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: Container(
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

  void _onTap() {
    if (widget.hasViewImage) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => _ViewImage(widget.url, type: type)));
    }
  }
}

class _ImageWidget extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final TypeImageViewer type;
  final double? width;
  final double? height;

  const _ImageWidget(this.url, {Key? key, required this.type, this.fit = BoxFit.contain, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TypeImageViewer.network:
        return CachedNetworkImageComp(url: url, fit: fit);
      case TypeImageViewer.storage:
        return Image.file(File(url), fit: fit, width: width, height: height);
      default:
        return Image.asset(url, fit: fit);
    }
  }
}
