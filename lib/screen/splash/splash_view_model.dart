import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/state/base_view_model.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';

class SplashViewModel extends BaseViewModel {

  @override
  Future<void> initialData() async {
    await delay(1000);
    setStatus(Status.success);  appNavigator.pushReplacementNamed(RoutePath.LOGIN,arguments: {'SplashViewModel args': runtimeType.toString()});
  }

  @override
  void onViewCreated() {
    super.onViewCreated();

  }
}
