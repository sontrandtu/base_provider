import 'dart:convert';

import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:achitech_weup/system/repository/new_repository.dart';

class SplashViewModel extends BaseViewModel {
  String data = '';

  @override
  Future<void> initialData() async {
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    if (await isConnecting) return;
    setStatus(Status.loading);

    ApiResponse response = await NewRepository.instance.getAllPost();
    if (response.isDataNull) return;
    data = jsonEncode(response.data);

    setStatus(Status.success);
  }

  void setData(){

    notifyListeners();
  }

}
