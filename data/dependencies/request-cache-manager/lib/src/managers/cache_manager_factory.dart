import 'package:request_cache_manager/src/managers/i_request_cache.dart';
import 'package:request_cache_manager/src/models/cache_model.dart';

class CacheManagerFactory extends IRequestCache {
  IRequestCache iRequestCache;

  CacheManagerFactory(this.iRequestCache);

  @override
  void clearAll() => iRequestCache.clearAll();

  @override
  CacheModel? get(String key) => iRequestCache.get(key);

  @override
  Future<void> put(CacheModel cache) => iRequestCache.put(cache);

  @override
  Future<void> remove(String key) => iRequestCache.remove(key);
}
