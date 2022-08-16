// import 'package:flutter/foundation.dart';
// import 'package:weup/common/core/sys/api_response.dart';
// import 'package:weup/common/network/client.dart';
// import 'package:weup/data/model/share_app_model.dart';
// import 'package:weup/domain/repository/widget_repository.dart';
//
// class WidgetRepositoryImpl implements WidgetRepository {
//   WidgetRepositoryImpl._internal();
//
//   static final WidgetRepositoryImpl _instance = WidgetRepositoryImpl._internal();
//
//   factory WidgetRepositoryImpl() => _instance;
//
//   @override
//   Future<ApiResponse<ShareAppModel?>> getShareApp() async {
//     return await compute(Client().service.getShareApp, <String, dynamic>{})
//         .wrapV2(cast: (json) => ShareAppModel.fromJson(json));
//   }
// }
