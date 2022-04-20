import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class Utils {
  static String md5Encode(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String sha256Encode(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  static String concatImageLink(String? path) {
    return 'https://cf.hidelink.vn/file/' + (path ?? '');
  }

  static String currency(dynamic value) {
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(value.toInt() / 100);
  }
}
