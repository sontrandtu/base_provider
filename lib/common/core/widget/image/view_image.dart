import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../button/icon_button_comp.dart';
import 'image_viewer_comp.dart';

class ImageData {
  List<String> urls;
  int index;

  ImageData({this.urls = const [], this.index = 0});
}

class ViewImage extends StatefulWidget {
  final ImageData data;
  final bool? isVisibleSend;
  final Function()? onSend;

  const ViewImage(this.data, {Key? key, this.isVisibleSend, this.onSend}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  late PageController pageController;
  int indexValue = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.data.index);
    indexValue = widget.data.index + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(alignment: Alignment.topCenter, children: [
        AppBar(
          toolbarOpacity: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
        ),
        Positioned.fill(child: pageViewImage),
        Positioned(
          left: 0,
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 6, left: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButtonComp(
                icon: Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 20,
                onPress: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.data.urls.length > 1,
          child: Positioned(
            top: 24,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                alignment: Alignment.center,
                child: Text(
                  '${(indexValue).toString()}/${widget.data.urls.length}',
                  style: const TextStyle(fontSize: 16, color: Colors.white, height: 1),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget get pageViewImage {
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 10,
          child: ImageViewer(
            widget.data.urls[index],
            fit: BoxFit.contain,
          ),
        );
      },
      itemCount: widget.data.urls.length,
      controller: pageController,
      onPageChanged: _onPageChanged,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      indexValue = index + 1;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
