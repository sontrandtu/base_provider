import 'package:domain/src/model/api_model.dart';

abstract class WidgetRepository {
  Future<dynamic> getShareApp();
  Future<dynamic> saveFile();
}
