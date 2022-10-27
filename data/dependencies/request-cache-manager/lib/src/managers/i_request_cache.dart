import '../models/cache_model.dart';

abstract class IRequestCache {
  Future<void> put(CacheModel cache);

  CacheModel? get(String key);

  Future<void> remove(String key);

  Future<void> clearAll();
}
