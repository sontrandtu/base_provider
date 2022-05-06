import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/network/client.dart';
import 'package:achitecture_weup/system/model/post.dart';
import 'package:flutter/foundation.dart';

class NewRepository extends BaseRepository {
  NewRepository._internal();

  static NewRepository get instance => NewRepository._internal();

  Future<ApiResponse<List<Post>>> getAllPost(Map<String,dynamic> dtaa) async {

    return await Client.getClient().getAllPost(dtaa['id'], dtaa['id2']).wrap();
  }
}
