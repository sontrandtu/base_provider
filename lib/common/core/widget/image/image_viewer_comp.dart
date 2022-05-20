import 'dart:io';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:flutter/material.dart';

import 'view_image.dart';

enum TypeImageViewer { none, assets, storage, network }

class ImageViewerComp extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit fit;
  final Color? color;
  final bool hasViewImage;

  const ImageViewerComp(
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
  State<ImageViewerComp> createState() => _ImageViewerCompState();
}

class _ImageViewerCompState extends State<ImageViewerComp> {
  late TypeImageViewer type;
  late String _url;

  @override
  void initState() {
    _url = widget.url;
    _checkType();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ImageViewerComp oldWidget) {
    if(oldWidget.url != widget.url) {
      _url = widget.url;
      _checkType();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _checkType() {
    if (_url.isStorage()) {
      type = TypeImageViewer.storage;
    } else if (_url.isValidUrl) {
      type = TypeImageViewer.network;
    } else if (_url.isAssets()) {
      type = TypeImageViewer.assets;
    } else {
      type = TypeImageViewer.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (empty(widget.url) || type == TypeImageViewer.none) return const Text('no img');
    return InkWell(
      onTap: widget.hasViewImage ? _onTap : null,
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

  void _onTap() => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewImage(widget.url, type: type)));
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
        return CachedNetworkImageComp(url: url, fit: fit, width: width, height: height);
      case TypeImageViewer.storage:
        return Image.file(File(url), fit: fit, width: width, height: height);
      default:
        return Image.asset(url, fit: fit, width: width, height: height);
    }
  }
}
