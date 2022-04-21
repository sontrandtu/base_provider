import 'package:achitech_weup/common/core/sys/base_view_model.dart';
import 'package:achitech_weup/system/model/post.dart';

class LoginViewModel extends BaseViewModel {
  Post? post;

  @override
  Future<void> initialData() async {
    print('${DateTime.now()} - initialData ${getArguments()}');


    post = getArguments();
  }

  @override
  void onViewCreated() {
    print('${DateTime.now()} - onViewCreated');
  }
}
