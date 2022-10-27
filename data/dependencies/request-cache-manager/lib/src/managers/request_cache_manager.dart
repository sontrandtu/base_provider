import 'package:collection/collection.dart';
import 'package:request_cache_manager/src/managers/request_cache_disk_manager.dart';

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
  Future<void> remove(String key) async {
    caches.removeWhere((element) => key.contains(element.key));
  }

  @override
  CacheModel? get(String key) {
    CacheModel? model = caches.singleWhereOrNull((element) => element.key == key);

    if ((model?.age ?? 0) > now) return model;
    remove(key);
    return null;
  }

  int get now => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  @override
  Future<void> clearAll() async{
    caches.clear();
  }
}
