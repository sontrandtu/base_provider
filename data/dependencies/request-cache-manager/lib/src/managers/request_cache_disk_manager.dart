import '../models/cache_model.dart';
import '../storage/cache_storage.dart';
import 'i_request_cache.dart';

class RequestCacheDiskManager implements IRequestCache {
  RequestCacheDiskManager._internal();

  static final RequestCacheDiskManager _manager = RequestCacheDiskManager._internal();

  factory RequestCacheDiskManager() => _manager;

  @override
  Future<void> put(CacheModel cache, {bool? forceReplace = false}) async {
    var data = CacheStorage.get<CacheModel>(cache.key);
    if (data == null) return await CacheStorage.put(cache.key, cache);
    if (forceReplace!) return await CacheStorage.put(cache.key, cache);

    int maxAge = data['age'];
    if (data != null && maxAge > now) return;
    return await CacheStorage.put(cache.key, cache);
  }

  @override
  void remove(String key) {
    CacheStorage.delete(key);
  }

  @override
  CacheModel? get(String key) {
    var data = CacheStorage.get<CacheModel>(key);
    if (data == null) return null;
    CacheModel cacheModel = CacheModel.fromJson(data);
    if (cacheModel.age > now) return cacheModel;
    remove(key);
    return null;
  }

  int get now => DateTime.now().millisecondsSinceEpoch ~/ 1000;

  @override
  void clearAll() {
    CacheStorage.clearData();
  }
}
