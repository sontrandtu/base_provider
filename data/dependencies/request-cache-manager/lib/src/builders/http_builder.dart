import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

abstract class HttpBuilder {
  HttpBuilder addBaseUrl(String? baseUrl);

  HttpBuilder addConnectTimeout(int timeout);

  HttpBuilder addReceiveTimeout(int timeout);

  HttpBuilder addSendTimeout(int timeout);

  HttpBuilder addDefaultHeaders(Map<String, dynamic> header);

  HttpBuilder addHeaders(Map<String, dynamic> header);

  HttpBuilder replaceHeaders(Map<String, dynamic> header);

  HttpBuilder addInterceptor(InterceptorBase interceptor);

  HttpBuilder addCacheMemory({int? ageSeconds, bool? forceReplace});

  HttpBuilder addCacheDisk({int? ageSeconds, bool? forceReplace});

  HttpBuilder withConverter<T>({T Function(dynamic json)? fromJson});

  HttpBuilder withConverterRestful<T>({T Function(dynamic json)? fromJson});

  HttpBuilder setPath(String path);

  HttpBuilder setMethod(Method? method);

  HttpBuilder setDataType(DataType dataType);

  HttpBuilder addBody(dynamic bodies);

  HttpBuilder addParameters(Map<String, dynamic>? params);

  HttpBuilder addPaths(Map<String, dynamic>? paths);

  HttpBuilder removeCacheByKeys(List<String>? keys);

  Future<Response<T>> request<T>();

  Future<ApiModel<T?>> get<T>();

  Future<ApiModel<T?>> post<T>();

  Future<ApiModel<T?>> put<T>();

  Future<ApiModel<T?>> patch<T>();

  Future<ApiModel<T?>> delete<T>();

  Dio build();
}
