import 'dart:developer';

import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/state/base_view_model.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:achitecture_weup/screen/home/home_page.dart';
import 'package:achitecture_weup/screen/payment/payment_page.dart';
import 'package:flutter/material.dart';

class HomeArgs {
  String admin = 'admin';
}

class HomeViewModel extends BaseViewModel {
  String? language;
  bool _valueSwitch = false;

  String radioValue1 = 'a';
  String radioValue2 = 'b';
  String radioValue3 = 'c';
  String radioValue4 = 'd';
  String groupRadio = 'e';

  bool val_1 = false;
  bool val_2 = false;
  bool val_3 = false;

  get valueSwitch => _valueSwitch;

  List<A> listA = [];
  List<A> listASelected = [];
  List<OptionMultipleSelect<A>> listMultipleData = [];



  @override
  Future<void> initialData() async {

    showLog(currentRoute);
    showLog(getArguments());
    showLog(Uri.parse(currentRoute ?? '').queryParameters);
    initData();

    setStatus(Status.success);
  }

  Future<void> changLanguage() async {

  }

  void setLanguage() {

  }

  void changeSwitch(bool? value) {
    _valueSwitch = value ?? false;
    notifyListeners();
  }

  void changeSwitch1(bool value) {
    val_1 = value;
    notifyListeners();
  }

  void changeSwitch2(bool value) {
    val_2 = value;
    notifyListeners();
  }

  void changeSwitch3(bool value) {
    val_3 = value;
    notifyListeners();
  }

  void changeRadio(String? value) {
    groupRadio = value ?? 'c';
    update();
  }

  void initData() {
    for (int i = 1; i <= 10; i++) {
      listA.add(A(hovaTen: 'Number $i', tuoi: i));
    }

    for (var element in listA) {
      listMultipleData.add(OptionMultipleSelect<A>(title: element.hovaTen ?? '', data: element));
    }
    log('initData ');
  }

  void onChangeMultiple(List<OptionMultipleSelect<A>> listValue) {
    for (var element in listValue) {
      listASelected.add(element.data);
    }

    log('LENGHT ${listASelected.length}');
  }

  void nextPage() async {
    Navigator.push(Application.navigator.currentContext!, MaterialPageRoute(builder: (context) => const PaymentPage(),));
  }
}
