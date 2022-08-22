import 'package:collection/collection.dart';

import '../models/cache_model.dart';
import 'i_request_cache.dart';

class RequestCacheManager implements IRequestCache {
  RequestCacheManager._internal();

  static final RequestCacheManager _manager = RequestCacheManager._internal();

  factory RequestCacheManager() => _manager;

  List<CacheModel> caches = [];

  @override
  Future<void> put(CacheModel cache, {bool? forceReplace = false}) async {
    CacheModel? model = caches.singleWhereOrNull((element) => element.key == cache.key);
    if (model == null) return caches.add(cache);
    if (forceReplace ?? false) {
      model = cache;
      return;
    }
    if (model.age > now) return;
    model = cache;
  }

  @override
  void remove(String key) {
    caches.removeWhere((element) => element.key.contains(key));
  }

  @override
  CacheModel? get(String key) {
    CacheModel? model = caches.singleWhereOrNull((element) => element.key == key);
    if (model == null) return model;
    if (model.age > now) return model;
    remove(key);
    return null;
  }

  int get now => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  @override
  void clearAll() => caches.clear();
}
