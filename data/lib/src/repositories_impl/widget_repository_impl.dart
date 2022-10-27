import 'dart:io';

import 'package:data/src/common/extensions.dart';
import 'package:data/src/config/api_paths.dart';
import 'package:data/src/network/client.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class WidgetRepositoryImpl implements WidgetRepository {
  WidgetRepositoryImpl._internal();

  static final WidgetRepositoryImpl _instance = WidgetRepositoryImpl._internal();

  factory WidgetRepositoryImpl() => _instance;

  @override
  Future<dynamic> getShareApp() async {
    final _queryParameters = <String, dynamic>{};
    final _data = {
      'phone': '0943574556',
      'password': '19022001',
      'file': [File('./ic_search.png')]
    };

    return await Client()
        .addCacheMemory()

        .setPath('/v1/login')
        .setDataType(DataType.FORM_DATA)
        .addParameters(_queryParameters)
        .addBody(_data)
        .request<ApiModel<UserDetailModel>>()
        .wrap();
  }

  @override
  Future saveFile() async {
    final _queryParameters = <String, dynamic>{};
    final _data = FormData.fromMap({
      'file': [File('./ic_search.png'), File('./ic_search.png')]
    });

    _queryParameters.removeWhere((key, value) => value == null);

    return await Client()
        .addBaseUrl('https://app.weuptech.vn')
        .addCacheDisk()

        .build()
        .post('/api/media', queryParameters: _queryParameters, data: _data);
  }

  @override
  Future addFeeling() async {
    final paths = {'lessonId': '1654649615pa1g8zjyf79v'};
    final bodies = {
      'images': ['123', '123'],
      'content': 'Bài học hay'
    };
    return await Client()

        .setPath(ApiPaths.ADD_FEELING)
        .setMethod(Method.POST)
        .addPaths(paths)
        .addBody(bodies)
        .request<ApiModel>()
        .wrap();
  }

  @override
  Future<ApiModel<List<FeelingModel>?>> getAllFeeling() async {
    final paths = {'lessonId': '1654649615pa1g8zjyf79v'};
    return await Client()
        .addCacheMemory()
               .setPath(ApiPaths.FEELINGS)
        .addPaths(paths)
        .request<ApiModel<List<FeelingModel>>>()
        .wrap();
  }

  @override
  Future<ApiModel<List<PostModel>?>> getAllPost() async {
    return await Client()
        // .addBaseUrl('https://jsonplaceholder.typicode.com')
        .addCacheMemory()
        // .withConverterRestful<List<PostModel>>(
        //     fromJson: (json) => json.map<PostModel>((element) => PostModel.fromJson(element)).toList())
        .setPath('/{id}/books/{bookId}/posts')
        .removeCacheByKeys([]).addPaths({'id': '123123', 'bookId': '123'}).addBody({'file': []}).get<List<PostModel>>();
  }
}

main() async {
  await CacheStorage().ensureInitialized('path');
  ApiModel<List<PostModel>?> response = await WidgetRepositoryImpl().getAllPost();
  print(response.data);
}
