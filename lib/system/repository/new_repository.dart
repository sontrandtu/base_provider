import 'package:achitecture_weup/common/core/sys/api_response.dart';
import 'package:achitecture_weup/common/network/client.dart';
import 'package:achitecture_weup/system/model/post.dart';
import 'package:flutter/foundation.dart';

class NewRepository {
  NewRepository._internal();

  static NewRepository get instance => NewRepository._internal();

  Future<ApiResponse<List<Post>>> getAllPost() async {
    return await compute(Client.getClient().getAllComments,<String, dynamic>{}).wrap();
  }
}
