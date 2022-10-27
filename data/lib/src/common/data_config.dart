import 'package:request_cache_manager/request_cache_manager.dart';

class DataConfig {
  DataConfig._internal();

  static final DataConfig _dataConfig = DataConfig._internal();

  factory DataConfig() => _dataConfig;
  bool _isReleaseMode = true;

  bool get isReleaseMode => _isReleaseMode;

  void setIsReleaseMode(bool b) => _isReleaseMode = b;

  Future<void> initializedDB({String? path}) => CacheStorage().ensureInitialized(path);
}
