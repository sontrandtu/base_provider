import 'package:flutter/material.dart';

class ThemeModel {
  final int? id;
  final ThemeData? data;

  ThemeModel({this.id, this.data});

  @override
  String toString() {
    return 'id: $id, data: $data';
  }
}
