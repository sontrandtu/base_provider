import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/resource/color/base_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;


enum ToastMode {
  none,
  success,
  error,
}

class ViewUtils {

  /// give access to FocusScope.of(context)
  static FocusNode? get focusScope => FocusManager.instance.primaryFocus;

  /// The window to which this binding is bound.
  static ui.SingletonFlutterWindow get window => ui.window;

  static Locale? get deviceLocale => ui.window.locale;

  ///The number of device pixels for each logical pixel.
  static double get pixelRatio => ui.window.devicePixelRatio;

  static Size get size => ui.window.physicalSize / pixelRatio;

  ///The horizontal extent of this size.
  static double get width => size.width;

  ///The vertical extent of this size
  static double get height => size.height;

  ///The distance from the top edge to the first unpadded pixel,
  ///in physical pixels.
  static double get statusBarHeight => ui.window.padding.top;

  ///The distance from the bottom edge to the first unpadded pixel,
  ///in physical pixels.
  static double get bottomBarHeight => ui.window.padding.bottom;

  ///The system-reported text scale.
  static double get textScaleFactor => ui.window.textScaleFactor;

  static double get heightStatusBar =>
      MediaQuery.of(Application.navigator.currentContext!).padding.top;

  static void toast(String msg, {ToastMode mode = ToastMode.none, double fontSize = 16.0}) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: _getToastColor(mode),
        textColor: ColorResource.textBody,
        fontSize: fontSize,
      );

  static Color _getToastColor(ToastMode mode) {
    switch(mode) {
      case ToastMode.success:
        return Colors.green;
      case ToastMode.error:
        return Colors.red;
      default:
        return ColorResource.primary;
    }
  }
}
