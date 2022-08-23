import 'package:achitecture_weup/common/page_manager/route_path.dart';
import 'package:data/data.dart';
import 'package:state/state.dart';

class SplashViewModel extends BaseViewModel {
  @override
  Future<void> initialData() async {
    await delay(1000);
    setStatus(Status.success);
    // appNavigator
    //     .pushReplacementNamed(RoutePath.LOGIN, arguments: {'SplashViewModel args': runtimeType.toString()});
    //
    WidgetRepositoryImpl().getAllFeeling();
  }
}
