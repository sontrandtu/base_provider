import 'package:request_cache_manager/request_cache_manager.dart';

class HeaderConfig {
  HeaderConfig._internal();

  static final HeaderConfig _config = HeaderConfig._internal();

  factory HeaderConfig() => _config;
  Map<String, dynamic> _defaultHeaders = {};

  Future<void> setDefaultHeader(Map<String, dynamic> headers) async {
    _defaultHeaders = headers;
    await CacheStorage().put(StorageKey.HEADER, headers);
  }

  Map<String, dynamic> getHeaders() {
    return _defaultHeaders = CacheStorage().get<Map<String, dynamic>>(StorageKey.HEADER) ?? {};
  }

  void addHeaders(Map<String, dynamic> headers) => _defaultHeaders.addAll(headers);

  Future<void> removeAll() => CacheStorage().delete(StorageKey.HEADER);
}
