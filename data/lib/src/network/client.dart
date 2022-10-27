import 'package:data/src/common/builders/http_builder.dart';
import 'package:data/src/common/header_config.dart';
import 'package:data/src/network/dio_builder.dart';
import 'package:domain/domain.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

class Client extends HttpBuilder {
  Dio? _dio;
  DioBuilder? _dioBuilder;
  PrettyDioLogger? _logger;
  BasicInterceptor? _basicInterceptor;
  InterceptorConverter? _interceptorConverter;
  final bool _isDebugMode = true;
  final String _baseUrl = 'https://erp.weuptech.vn/api/v1';
  final int _connectTimeout = 10000;
  final int _receiveTimeout = 10000;
  final int _sendTimeout = 10000;

/*
* Khi cần thay đổi base url hãy kế thừa class này và ghi đè lại base url
* */
  String get baseUrl => _baseUrl;

  Client() {
    _logger ??= PrettyDioLogger(
        requestHeader: _isDebugMode, requestBody: _isDebugMode, responseBody: _isDebugMode, responseHeader: _isDebugMode, error: _isDebugMode);

    _basicInterceptor ??= BasicInterceptor();
    _interceptorConverter ??= InterceptorConverter(dio: _dio);
    _dio = Dio(BaseOptions(
        baseUrl: _baseUrl,
        headers: HeaderConfig().getHeaders(),
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
        sendTimeout: _sendTimeout))
      ..interceptors.addAll([_logger!, _basicInterceptor!,_interceptorConverter!]);

    _dioBuilder = DioBuilder(_dio!);
  }

  /*
  * Custom 1 url khác
  * */
  @override
  HttpBuilder addBaseUrl(String? baseUrl) {
    if (baseUrl != null) _dio?.options.baseUrl = baseUrl;
    return this;
  }

  /*
  * Custom thời gian timeout
  * */
  @override
  HttpBuilder addConnectTimeout(int timeout) {
    _dio?.options.connectTimeout = timeout;
    return this;
  }

  /*
  * Custom thời gian timeout
  * */
  @override
  HttpBuilder addReceiveTimeout(int timeout) {
    _dio?.options.receiveTimeout = timeout;
    return this;
  }

  /*
  * Custom thời gian timeout
  * */
  @override
  HttpBuilder addSendTimeout(int timeout) {
    _dio?.options.sendTimeout = timeout;
    return this;
  }

  @Deprecated('Do not use this function. Default header is HeaderConfig().getHeader()')
  @override
  HttpBuilder addDefaultHeaders(Map<String, dynamic> header) {
    _dio?.options.headers = header;
    return this;
  }

  /*
  * Thêm headers
  * */
  @override
  HttpBuilder addHeaders(Map<String, dynamic> header) {
    _dio?.options.headers.addAll(header);
    return this;
  }

  /*
  * Ghi đè headers
  * */
  @override
  HttpBuilder replaceHeaders(Map<String, dynamic> header) {
    _dio?.options.headers = header;
    return this;
  }

  /*
  * Thêm 1 interceptor khác
  * */
  @override
  HttpBuilder addInterceptor(Interceptor interceptor) {
    _dio?.interceptors.add(interceptor);
    return this;
  }

  /*
  * Thêm cache vào file
  * */
  @override
  HttpBuilder addCacheDisk({int? ageSeconds, bool? forceReplace}) {
    _dio?.interceptors.add(InterceptorDisk(maxAgeSecond: ageSeconds, forceReplace: forceReplace));
    return this;
  }

  /*
  * Thêm cache vào ram
  * */
  @override
  HttpBuilder addCacheMemory({int? ageSeconds, bool? forceReplace}) {
    _dio?.interceptors.add(InterceptorMemory(maxAgeSecond: ageSeconds, forceReplace: forceReplace));
    return this;
  }

  /*
  *  Luôn gọi đến converter để parse json sang object hoặc lấy từ cache, hoặc lấy json thuần
  * */
  @override
  HttpBuilder withConverter<T>(JsonConverter<T>? fromJson) {
    _dio?.interceptors.remove(_interceptorConverter);
    _interceptorConverter = InterceptorConverter<T>(dio: _dio);
    _interceptorConverter?.setJsonConverter(fromJson);
    _dio?.interceptors.add(_interceptorConverter!);
    return this;
  }

  @override
  HttpBuilder withConverterRestful({JsonConverter? fromJson}) {
    // _interceptorConverter?.setJsonConverter(fromJson);
    return this;
  }

  /*
  *  Xây dựng lên đối tượng dio
  * */
  @override
  Dio build() {
    return _dio ?? Dio();
  }

  @override
  HttpBuilder addBody(bodies) {
    _dioBuilder?.addBody(bodies);
    setDataType(DataType.JSON);
    return this;
  }
  @override
  HttpBuilder addJsonBody(bodies) {
    _dioBuilder?.addBody(bodies);
    setDataType(DataType.JSON);
    return this;
  }

  @override
  HttpBuilder addTextBody(bodies) {
    _dioBuilder?.addBody(bodies);
    setDataType(DataType.TEXT);
    return this;
  }

  @override
  HttpBuilder addPart(dynamic bodies) {
    _dioBuilder?.addBody(bodies);
    setDataType(DataType.FORM_DATA);
    return this;
  }

  @override
  HttpBuilder addParameters(Map<String, dynamic>? params) {
    _dioBuilder?.addParameters(params);
    return this;
  }

  @override
  HttpBuilder addPaths(Map<String, dynamic>? paths) {
    _dioBuilder?.addPaths(paths);
    return this;
  }

  @override
  HttpBuilder removeCacheByKeys(List<String>? keys) {
    _dioBuilder?.removeCacheByKeys(keys);
    return this;
  }

  @override
  HttpBuilder setDataType(DataType? dataType) {
    _dioBuilder?.setDataType(dataType);
    return this;
  }

  @override
  HttpBuilder setMethod(Method? method) {
    _dioBuilder?.setMethod(method);
    return this;
  }

  @override
  HttpBuilder setPath(String path) {
    _dioBuilder?.setPath(path);
    return this;
  }

  /*
  *  Gọi request bằng hàm này để sử dụng các tiện ích
  *
  *  Nếu truyền lên file thì chỉ cần truyền vào body file: {'file': [File('./ic_search.png')]} hoặc {'file': File('./ic_search.png')}
  *  Nếu truyền lên List<String> thì chỉ cần truyền vào body file:   {'images': ['string1', 'string2']}
  *  Nếu truyền raw json thông thường thì chỉ cần truyền lên map {'key':'value'}
  *
  *  Khi api có Patch thì truyền vào paths với key trùng với key ở url:
  *  url: '/v1/lesson-contact-comment/{lessonId}'
  *  paths: {'lessonId': '1654649615pa1g8zjyf79v'}
  *
  *  Method mặc định là GET
  * */
  @override
  Future<Response<T>> request<T>() async {
    Response<T> response = await _dioBuilder!.build<T>();
    _onDestroy();
    return response;
  }

  void _onDestroy() {
    _dioBuilder = null;
    _dio = null;
    _logger = null;
    _interceptorConverter = null;
    _basicInterceptor = null;
  }

  @override
  Future<ApiModel<T?>> delete<T>() async {
    ApiModel<T?> response = await _dioBuilder!.delete<T>();
    _onDestroy();
    return response;
  }

  @override
  Future<ApiModel<T?>> get<T>() async {
    ApiModel<T?> response = await _dioBuilder!.get<T>();
    _onDestroy();
    return response;
  }

  @override
  Future<ApiModel<T?>> patch<T>() async {
    ApiModel<T?> response = await _dioBuilder!.patch<T>();
    _onDestroy();
    return response;
  }

  @override
  Future<ApiModel<T?>> post<T>() async {
    ApiModel<T?> response = await _dioBuilder!.post<T>();
    _onDestroy();
    return response;
  }

  @override
  Future<ApiModel<T?>> put<T>() async {
    ApiModel<T?> response = await _dioBuilder!.put<T>();
    _onDestroy();
    return response;
  }


}
