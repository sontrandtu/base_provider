import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Routing {
  RouteSettings? settings;
  dynamic arguments;
  String? routeName;
  String? originalName;

  Routing({this.settings})
      : arguments = settings?.arguments,
        routeName = settings?.name,
        originalName = settings?.name?.split('?').firstOrNull;
}
