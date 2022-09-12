import 'package:state/src/routing/routing.dart';

final AppRouting = AppRoutingConfig();

class AppRoutingConfig {
  AppRoutingConfig._internal();

  static final AppRoutingConfig _appRouting = AppRoutingConfig._internal();

  factory AppRoutingConfig() => _appRouting;

  Routing? _routing;

  void setRouting(Routing routing) => _routing = routing;

  /*
  * Route hiện tại
  * */
  String? get currentRoute => _routing?.originalName;

  /*
  * Route kèm parameter
  * */
  String? get originalRoute => _routing?.routeName;

  /*
  * Arguments từ page trước
  * */
  dynamic get arguments => _routing?.arguments;

  /*
  * Parameter từ page trước
  * */
  Map<String, dynamic>? get parameters => Uri.tryParse(originalRoute ?? '')?.queryParameters;
}
