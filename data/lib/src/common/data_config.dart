import 'package:request_cache_manager/request_cache_manager.dart';

class DataConfig {
  static Future<void> ensureInitialized() async {
    await CacheStorage.ensureInitialized();
  }
}
