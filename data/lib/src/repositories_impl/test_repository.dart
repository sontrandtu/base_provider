import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class TestRepository {
  Future<ApiModel<dynamic>> login() {
    final body = {'phone': '0000000005', 'password': '123123', 'device_token': '123'};
    final params = {'param1':'value1','param2':'value2'};
    return Client().setPath('/login').addPaths({'id':'OK'}).addParameters(params).addPart(body).post<dynamic>();
  }
}

main() async {
  await DataConfig.ensureInitialized();
  ApiModel<dynamic> response = await TestRepository().login();
  print(response.message);
}
