import 'package:achitech_weup/common/local_storage/hive_storage.dart';

class AccountManager {
  static final AccountManager _accountManager = AccountManager._internal();

  factory AccountManager() {
    return _accountManager;
  }

  AccountManager._internal();

  void setAccountInfo(dynamic accountInfo) {}

  dynamic getInfo() {}

}
