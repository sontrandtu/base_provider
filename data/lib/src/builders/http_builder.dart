import 'package:dio/dio.dart';
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

  HttpBuilder withConverter<T>({T Function(Map<String, dynamic> json) fromJson});

  HttpBuilder request({String? path, String? method, Map<String,dynamic>? body, FormData? form,Map<String,dynamic>? queryParameters});

  Dio build();
}
