import '../models/cache_model.dart';

abstract class IRequestCache {
  Future<void> put(CacheModel cache);

  void remove(String key);

  CacheModel? get(String key);
}
