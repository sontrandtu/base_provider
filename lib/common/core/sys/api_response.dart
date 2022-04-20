import 'dart:developer';

import 'package:achitech_weup/common/core/sys/server_error.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class ApiResponse<T> {
  T? data;
  String? message;
  int? code;
  dynamic error;

  ApiResponse({this.data, this.code, this.message, this.error}) {
    if (error is DioError) {
      if (message == null || (message?.isEmpty ?? true)) {
        message = ServerError.withDioError(error: error).errorMessage;
      }
      return;
    } else {
      message = error.toString();
    }
  }

  bool get isOk => code == 200;
  bool get isOnWebsite => code == 302;
}

extension FutureExtensions<T> on Future<HttpResponse<T>> {
  Future<ApiResponse<T>> wrap() async {
    try {
      final httpResponse = await this;
      return Future.value(ApiResponse<T>(data: httpResponse.data, code: httpResponse.response.statusCode));
    } catch (error) {
      log('FutureExtensions ===================================${error.toString()}');
      if (error is DioError) {
        if(error.response == null){
          return Future.value(ApiResponse(code: error.response?.statusCode ?? 0, error: error));
        }else{
          final String? message = error.response?.data['message'];
          return Future.value(ApiResponse(code: error.response?.statusCode ?? 0, error: error,message: message));
        }

      } else {
        return Future.value(ApiResponse(error: error));
      }
    }
  }
}
