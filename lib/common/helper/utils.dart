import 'package:intl/intl.dart';

class Utils {

  static String concatImageLink(String? path) {
    return 'https://cf.hidelink.vn/file/' + (path ?? '');
  }

  static String currency(dynamic value) {
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(value.toInt() / 100);
  }
}
