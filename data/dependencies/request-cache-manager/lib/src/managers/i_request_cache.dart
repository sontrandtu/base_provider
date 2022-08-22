import '../models/cache_model.dart';

abstract class IRequestCache {
  Future<void> put(CacheModel cache);

  CacheModel? get(String key);

  void remove(String key);

  void clearAll();
}
