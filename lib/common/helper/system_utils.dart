import 'package:achitecture_weup/common/helper/file_utils.dart';
import 'package:flutter/cupertino.dart';

// ignore: non_constant_identifier_names
void print_r(dynamic input) {
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

bool systemIsEmpty([dynamic data, bool hasZero = false]) {
  if (data == null) return true;
  if ((data is Map || data is List) && data.length == 0) return true;
  if ((data is Map || data is Iterable) && data.isEmpty) return true;
  if (data is bool) return !data;
  if ((data is String || data is num) && (data == '0' || data == 0)) return hasZero;

  return data.toString().isEmpty;
}


Future<void> openFile(BuildContext context, {required String url}) async {
  return FileUtils().open(context, url: url);
}
