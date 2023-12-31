import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageComp extends StatelessWidget {
  final double? width;
  final double? height;
  final String url;
  final String borderStyle;
  final Widget? widgetPlaceHolder, widgetError;
  final Color? backgroundColor;
  final double borderWidth;
  final Color borderColor;
  final String? resourceErrorImage;
  final BorderRadius? borderRadius;
  final int? placeholderDuration;
  final BoxFit fit;

  const CachedNetworkImageComp({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderStyle = 'all',
    this.widgetPlaceHolder,
    this.backgroundColor,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.resourceErrorImage,
    this.widgetError,
    this.borderRadius,
    this.placeholderDuration,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        // fadeOutDuration: Duration(microseconds: placeholderDuration ?? 600),
        // fadeInDuration: Duration(microseconds: placeholderDuration ?? 300),
        imageUrl: url,
        fit: fit,
        placeholder: (_, __) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: borderWidth, color: borderColor),
          ),
          child: widgetPlaceHolder,
        ),
        errorWidget: (_, __, ___) =>
            widgetError ??
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(width: borderWidth, color: borderColor),
              ),
              child: const Icon(
                Icons.image,
                color: Colors.blueGrey,
              ),
            ),
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: borderWidth, color: borderColor),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
