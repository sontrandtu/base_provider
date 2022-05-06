import 'package:flutter/cupertino.dart';
import 'dart:io' as io;

// ignore: non_constant_identifier_names
print_r(dynamic input) {
  if (input != null) {
    if (input is String || input is num) {
      debugPrint('$input');
      return;
    }

    if (input is Map) {
      input.forEach((k, v) {
        debugPrint('${k.runtimeType} - ${v.runtimeType}: $k - $v');
      });
      return;
    }
    if (input is List) {
      for (var e in input) {
        debugPrint('${e.runtimeType}: $e');
      }
      return;
    }
  }
}
