import 'package:state/state.dart';

import '../../common/core/page_manager/route_path.dart';

class SplashViewModel extends BaseViewModel {

  @override
  Future<void> initialData() async {
    await delay(1000);
    setStatus(Status.success);  appNavigator.pushReplacementNamed(RoutePath.LOGIN,arguments: {'SplashViewModel args': runtimeType.toString()});
  }

}
