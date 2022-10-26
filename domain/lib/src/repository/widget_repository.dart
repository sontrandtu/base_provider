import 'package:domain/domain.dart';

abstract class WidgetRepository {
  Future<dynamic> getShareApp();

  Future<dynamic> saveFile();

  Future<dynamic> addFeeling();

  Future<ApiModel<List<FeelingModel>?>> getAllFeeling();
  Future<ApiModel<List<PostModel>?>> getAllPost();
}
