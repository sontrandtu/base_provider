import 'dart:io';
import 'package:data/src/common/dio_extensiton.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class DioBuilder extends DioBuilderBase {
  DioBuilder(Dio dio) {
    _dio = dio;
  }

  late final Dio _dio;
  final Map<String, dynamic> _params = {};
  final Map<String, dynamic> _extras = {};

  String _path = '';
  String _methodText = MethodText.GET;
  dynamic _body;

  @override
  DioBuilderBase addBody(bodies) {
    _body = bodies;
    return this;
  }

  @override
  DioBuilderBase addParameters(Map<String, dynamic>? params) {
    if (params != null) _params.addAll(params);
    return this;
  }

  @override
  DioBuilderBase addPaths(Map<String, dynamic>? paths) {
    _extras.addAll({ExtraKey.PATHS: paths});
    return this;
  }

  @override
  DioBuilderBase setDataType(DataType dataType) {
    switch (dataType) {
      case DataType.FORM_DATA:
        _body.forEach((key, value) {
          if (value is List<File>) value = value.map((e) => MultipartFile.fromFileSync(e.path)).toList();
          if (value is File) value = MultipartFile.fromFileSync(value.path);
        });
        _body = FormData.fromMap(_body);
        break;
      case DataType.JSON:
      default:
    }
    return this;
  }

  @override
  DioBuilderBase setMethod(Method? method) {
    switch (method) {
      case Method.GET:
        _methodText = MethodText.GET;
        break;
      case Method.POST:
        _methodText = MethodText.POST;
        break;
      case Method.PUT:
        _methodText = MethodText.PUT;
        break;
      case Method.PATCH:
        _methodText = MethodText.PATCH;
        break;
      case Method.DELETE:
        _methodText = MethodText.DELETE;
        break;

      default:
        _methodText = MethodText.GET;
    }
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
        queryParameters: _params, data: _body, options: Options(method: _methodText, extra: _extras));
  }

  @override
  Future<ApiModel<T?>> delete<T>() async {
    return   _dio
        .request<ApiModel<T>>(_path,
            queryParameters: _params, data: _body, options: Options(method: MethodText.DELETE, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> get<T>() async {
    return await _dio
        .request<ApiModel<T>>(_path,
            queryParameters: _params, data: _body, options: Options(method: MethodText.GET, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> patch<T>() async {
    return  _dio
        .request<ApiModel<T>>(_path,
            queryParameters: _params, data: _body, options: Options(method: MethodText.PATCH, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> post<T>() async {
    return await _dio
        .request<ApiModel<T>>(_path,
            queryParameters: _params, data: _body, options: Options(method: MethodText.POST, extra: _extras))
        .wrap();
  }

  @override
  Future<ApiModel<T?>> put<T>() async {
    return await _dio
        .request<ApiModel<T>>(_path,
            queryParameters: _params, data: _body, options: Options(method: MethodText.PUT, extra: _extras))
        .wrap();
  }
}
