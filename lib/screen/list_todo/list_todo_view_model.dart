import 'package:achitecture_weup/common/core/state/base_view_model.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';


class ListTodoViewModel extends BaseViewModel {
  GlobalKey<AnimatedListState> keyList = GlobalKey<AnimatedListState>();
  List<String> animatedList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  @override
  Future<void> initialData() async {
    setStatus(Status.success);
  }

  void insert() {
    animatedList.add('New Item ${animatedList.length}');
    keyList.currentState!.insertItem(animatedList.length - 2);

  }

  void remove() {
    animatedList.removeLast();
  }
}
