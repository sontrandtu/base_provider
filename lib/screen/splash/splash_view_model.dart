import 'dart:convert';

import 'package:achitech_weup/application.dart';
import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:achitech_weup/system/model/post.dart';
import 'package:achitech_weup/system/repository/new_repository.dart';
import 'package:flutter/cupertino.dart';

class SplashViewModel extends BaseViewModel {
  List<Post> posts = [];

  @override
  Future<void> initialData() async {

  }

@override
  void onViewCreated() {
    setStatus(Status.success);
    Navigator.pushReplacementNamed(navigator.currentContext!, RoutePath.login);
  }
}
