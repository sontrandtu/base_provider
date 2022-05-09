import 'dart:io';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


enum TypeImageViewer { assets, storage, network }

class ImageViewer extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxFit fit;
  final Color? color;

  const ImageViewer(
    this.url, {
    Key? key,
    this.width = 100,
    this.height = 100,
    this.borderRadius,
    this.padding,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TypeImageViewer type = TypeImageViewer.assets;
    RegExp regExp = RegExp(r'^\/(storage|data)[^\.]');
    if (regExp.hasMatch(url)) {
      type = TypeImageViewer.storage;
    } else if (url.isValidUrl) {
      type = TypeImageViewer.network;
    } else {
      type = TypeImageViewer.assets;
    }
    return InkWellComp(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => _ViewImage(url)));
      },
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(color: color),
          child: _imgWidget(type),
        ),
      ),
    );
  }

  Widget _imgWidget(TypeImageViewer type) {
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
    } else {
      return Image.asset(
        url,
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
}

class _ViewImage extends StatelessWidget {
  final String url;
  const _ViewImage(this.url,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print_r(url);
    return Scaffold(
      appBar: AppBarComp(title: _getName(url), onLeading: () {},),
      body: PhotoView(
        imageProvider: NetworkImage(url),
        enablePanAlways: true,
        loadingBuilder: (context, progress) => Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: progress == null
                  ? null
                  : progress.cumulativeBytesLoaded /
                  progress.expectedTotalBytes!,
            ),
          ),
        ),
        enableRotation: true,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,

      ),
    );
  }

  String _getName(String input) {
    final regExp = RegExp(r'\/\w+\.(jpg|png|jpge|gif)');
    if(input.lastIndexOf(regExp) != -1) {
      return input.substring(input.lastIndexOf(regExp) + 1);
    }
    return input;
  }
}
