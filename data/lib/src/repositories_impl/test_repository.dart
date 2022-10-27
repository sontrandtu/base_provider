import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class TestRepository {
  Future<ApiModel<dynamic?>> login() async {
    final body = {'phone': '0000000005', 'password': '123123', 'device_token': '123'};
    ApiModel<dynamic?> response = await Client().setPath(ApiPaths.LOGIN).addPaths({'id': 'OK', 'id1': "oke"}).addPart(body).post();
    await HeaderConfig().setDefaultHeader({'token': response.data['token'], 'id': response.data['id']});
    return response;
  }
}

class LoginModel {
  int? id;
  Null? isIdentified;
  String? token;

  LoginModel({this.id, this.isIdentified, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isIdentified = json['is_identified'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_identified'] = this.isIdentified;
    data['token'] = this.token;
    return data;
  }
}

main() async {
  await DataConfig().initializedDB(path: './storage/');
  ApiModel<dynamic> response = await TestRepository().login();

  print(response);
  print(response.data.runtimeType);
  print(response.data['token']);

  print(HeaderConfig().getHeaders());
  await DataConfig().removeAll();
  print(HeaderConfig().getHeaders());
}
