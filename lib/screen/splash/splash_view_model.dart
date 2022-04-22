import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:achitecture_weup/system/model/post.dart';

class SplashViewModel extends BaseViewModel {
  List<Post> posts = [];

  @override
  Future<void> initialData() async {
    await delay(1000);
    setStatus(Status.success);
    appNavigator.pushReplacementNamed(RoutePath.LOGIN);
  }
}
