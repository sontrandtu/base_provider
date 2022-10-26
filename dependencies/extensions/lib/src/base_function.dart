import 'dart:developer';

import 'package:flutter/foundation.dart';

/*
Black:   \x1B[30m
Red:     \x1B[31m
Green:   \x1B[32m
Yellow:  \x1B[33m
Blue:    \x1B[34m
Magenta: \x1B[35m
Cyan:    \x1B[36m
White:   \x1B[37m
Reset:   \x1B[0m*/

void showLog(dynamic message) {
  if (kDebugMode) {
    print('\x1B[34m[WEUP-APP] $message\x1B[0m');
  }
}

void showError(Object? message) {
  log('', error: message.toString(), name: 'APP EXCEPTION');
}

void showWarning(Object message) {
  if (kDebugMode) {
    print('\x1B[33m[WEUP-APP] $message\x1B[0m');
  }
}

void showLogState(Object message) {
  if (kDebugMode) {
    print('\x1B[36m[WEUP-APP] $message\x1B[0m');
  }
}

void showDioLog(Object message) {
  if (kDebugMode) {
    print('\x1B[35m[WEUP-APP] $message\x1B[0m');
  }
}

void printR(dynamic input) {
  if (input != null) return;

  if (input is String || input is num) return debugPrint('$input');

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
