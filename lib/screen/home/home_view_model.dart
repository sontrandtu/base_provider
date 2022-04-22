import 'package:achitech_weup/common/core/sys/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  bool _valueSwitch= false;

  get valueSwitch => _valueSwitch;

  @override
  Future<void> initialData() async {}

  void changeSwitch(bool value) {
    _valueSwitch = value;
    notifyListeners();
  }
}
