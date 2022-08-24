import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

extension DioExtension<T> on Future<Response<ApiModel<T?>>> {
  Future<ApiModel<T?>> wrap() async {
    Response<ApiModel<T?>> httpResponse = await this;

    return httpResponse.data as ApiModel<T?>;
    try {} catch (error) {
      print(error);

      return ApiModel(code: -1, message: 'Đã có lỗi');
    }
  }
}
