import 'dart:io';

import 'package:achitech_weup/common/helper/app_common.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseImage {
  static Widget storage(
      {String? path, BoxFit? boxFit, double? width, double? height, BorderRadius? borderRadius}) {
    return Image.file(
      File(path ?? ''),
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.cover,
    );
  }

  static Widget asserts(
      {String? path,
      BoxFit? boxFit,
      double? width,
      double? height,
      BorderRadius? borderRadius,
      Color? color}) {
    return Image.asset(
      path ?? '',
      width: width,
      height: height,
      fit: boxFit,
      color: color,
    );
  }

  static Widget svg(
      {String? path,
      BoxFit? boxFit,
      double? width,
      double? height,
      BorderRadius? borderRadius,
      Color? color}) {
    return SvgPicture.asset(
      path ?? '',
      fit: boxFit ?? BoxFit.cover,
      color: color,
    );
  }

  static Widget network(
      {String? path,
      BoxFit? boxFit,
      double? width,
      double? height,
      BorderRadius? borderRadius,
      Color? color}) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: path ?? '',
        color: color,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider,fit: boxFit ?? BoxFit.fill),
          ),
        ),
        placeholder: (context, url) =>  Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
              strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(ColorResource.primary)),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error,color: ColorResource.primary,),
      ),
    );
  }
}
