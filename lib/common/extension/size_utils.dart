import 'package:flutter/material.dart';

class SizeUtils {
  GlobalKey? key;

  Size? get size => key?.currentContext?.size;

  SizeUtils({this.key});
}
