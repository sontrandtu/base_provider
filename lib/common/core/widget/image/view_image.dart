import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'image_viewer.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewImage extends StatelessWidget {
  final dynamic image;
  final TypeImageViewer type;

  const ViewImage(this.image, {Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          image is List
              ? _ImageGallery(image, type: type)
              : _DefaultView(image, type: type),
          const SafeArea(child: BackButton(color: Colors.white)),
        ],
      ),
    );
  }
}

class _DefaultView extends StatelessWidget {
  final String image;
  final TypeImageViewer type;

  const _DefaultView(this.image, {Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: _imageProvider(image, type),
      enablePanAlways: true,
      loadingBuilder: (context, progress) => Center(
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.8),
          child: const Center(
            child: CircularProgressIndicator(
              // value: progress == null
              //     ? null
              //     : progress.cumulativeBytesLoaded /
              //     (progress.expectedTotalBytes ??
              //         progress.cumulativeBytesLoaded),
            ),
          ),
        ),
      ),
      // enableRotation: true,
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 1.8,
      initialScale: PhotoViewComputedScale.contained,
      basePosition: Alignment.center,
    );
  }
}


class _ImageGallery extends StatefulWidget {
  final List<Map<String, dynamic>> images;
  final TypeImageViewer type;

  const _ImageGallery(this.images, {Key? key, required this.type}) : super(key: key);

  @override
  State<_ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<_ImageGallery> {

  late int current;
  late PageController pageController;

  @override
  void initState() {
    current = 0;
    pageController = PageController(initialPage: current);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: _imageProvider(widget.images[index]['path'], widget.type),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
            );
          },
          itemCount: widget.images.length,
          loadingBuilder: (context, event) => const CircularProgressIndicator(),
          // backgroundDecoration: widget.backgroundDecoration,
          pageController: pageController,
          onPageChanged: _onPageChanged,
        ),
      ],
    );
  }

  void _onPageChanged(int index) {}

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}


ImageProvider _imageProvider(String url, TypeImageViewer type) {
  if (type == TypeImageViewer.network) {
    return NetworkImage(url);
  } else if (type == TypeImageViewer.storage) {
    return FileImage(File(url));
  }
  return ExactAssetImage(url);
}