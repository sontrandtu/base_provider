import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

abstract class DioBuilderBase {
  DioBuilderBase setPath(String path);

  DioBuilderBase setMethod(Method? method);

  DioBuilderBase setDataType(DataType? dataType);

  DioBuilderBase addBody(dynamic bodies);

  DioBuilderBase addParameters(dynamic params);

  DioBuilderBase addPaths(Map<String, dynamic>? paths);

  DioBuilderBase removeCacheByKeys(List<String>? keys);

  @Deprecated('This function should not use')
  Future<Response<T>> build<T>();

  Future<ApiModel<T?>> get<T>();

  Future<ApiModel<T?>> post<T>();

  Future<ApiModel<T?>> put<T>();

  Future<ApiModel<T?>> patch<T>();

  Future<ApiModel<T?>> delete<T>();
}
