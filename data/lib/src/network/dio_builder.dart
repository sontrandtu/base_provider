import 'dart:convert';
import 'dart:io';

import 'package:data/src/common/builders/dio_builder_base.dart';
import 'package:data/src/common/extensions.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class DioBuilder extends DioBuilderBase {
  DioBuilder(Dio dio) : _dio = dio;

  late final Dio _dio;
  final Map<String, dynamic> _params = {};
  final Map<String, dynamic> _extras = {};

  String _path = '';
  String _methodText = 'MethodText.GET';
  dynamic _body;
  String _contentType = 'application/json; charset=utf-8';

  @override
  DioBuilderBase addBody(bodies) {
    _body = bodies;
    return this;
  }

  @override
  DioBuilderBase addParameters(params) {
    if (params == null) return this;
    if (params is Object) params = jsonDecode(jsonEncode(params));
    _params.addAll(params);
    return this;
  }

  @override
  DioBuilderBase addPaths(Map<String, dynamic>? paths) {
    _extras.addAll({ExtraKey.PATHS: paths});
    return this;
  }

  @override
  DioBuilderBase setDataType(DataType? dataType) {
    if (_body is Object) _body = jsonDecode(jsonEncode(_body));
    switch (dataType) {
      case DataType.FORM_DATA:
        _body = (_body as Map<String, dynamic>).formData;
        // _contentType = 'multipart/form-data; boundary=${_body.boundary}';
        break;
      case DataType.FORM_URL_ENCODED:
        _body = _body.urlEncode;
        // _contentType = 'application/x-www-form-urlencoded';
        break;
      case DataType.JSON:
      default:
    }
    return this;
  }

  @override
  DioBuilderBase setMethod(Method? method) {
    _methodText = method?.name ?? '';
    return this;
  }

  @override
  DioBuilderBase setPath(String path) {
    _path = path;
    return this;
  }

  @override
  DioBuilderBase removeCacheByKeys(List<String>? keys) {
    _extras.addAll({ExtraKey.KEYS: keys});
    return this;
  }

  @override
  Future<Response<T>> build<T>() async {
    return await _dio.request<T>(_path,
        queryParameters: _params, data: _body, options: Options(method: _methodText, extra: _extras, contentType: _contentType));
  }

  @override
  Future<ApiModel<T?>> delete<T>() async {
    return _dio
        .request<ApiModel<T>>(_path, queryParameters: _params, data: _body, options: Options(method: Method.DELETE.name, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> get<T>() async {
    return await _dio
        .request<ApiModel<T>>(_path, queryParameters: _params, data: _body, options: Options(method: Method.GET.name, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> patch<T>() async {
    return _dio
        .request<ApiModel<T>>(_path, queryParameters: _params, data: _body, options: Options(method: Method.PATCH.name, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> post<T>() async {
    return await _dio
        .request<ApiModel<T>>(_path, queryParameters: _params, data: _body, options: Options(method: Method.POST.name, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> put<T>() async {
    return await _dio
        .request<ApiModel<T>>(_path, queryParameters: _params, data: _body, options: Options(method: Method.PUT.name, extra: _extras))
        .wrap();
  }
}
