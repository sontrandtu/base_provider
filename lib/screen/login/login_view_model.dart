import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/page_manager/app_setting.dart';
import 'package:achitech_weup/common/core/sys/base_view_model.dart';

class LoginViewModel extends BaseViewModel{
  String? args;
  @override
  Future<void> initialData() {
   print(AppSetting.arguments);
   args = AppSetting.arguments;
    return super.initialData();
  }
}