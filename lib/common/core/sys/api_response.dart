import 'dart:io';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class ApiResponse<T> {
  T? data;
  String? message;
  int? code;

  ApiResponse({this.data, this.code, this.message});
}

extension FutureExtensions<T> on Future<HttpResponse<T?>> {
  Future<ApiResponse<T>> wrap() async {
    try {
      HttpResponse httpResponse = await this;

      final String? okMessage = httpResponse.response.data['message'];
      final int? okErrorCode = httpResponse.response.data['error'];
      return Future.value(ApiResponse(
          code: okErrorCode ?? httpResponse.response.statusCode,
          message: okMessage,
          data: httpResponse.data));
    } catch (error) {
      showError(error);
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.response:
            return _okError(error);

          case DioErrorType.sendTimeout:
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
            return Future.value(
                ApiResponse(code: error.response?.statusCode, message: HttpConstant.TIME_OUT));

          default:
            return Future.value(ApiResponse(code: error.response?.statusCode, message: HttpConstant.UNKNOWN));
        }
      }

      return Future.value(ApiResponse(message: HttpConstant.UNKNOWN));
    }
  }

  Future<ApiResponse<T>> _okError(DioError error) {
    int? statusCode = error.response?.statusCode;
    String? message = '$statusCode - ${error.response?.statusMessage}';

    switch (statusCode) {
      case HttpStatus.forbidden:
        return Future.value(ApiResponse(code: error.response?.statusCode, message: HttpConstant.FORBIDDEN));

      case HttpStatus.unauthorized:
        return Future.value(
            ApiResponse(code: error.response?.statusCode, message: HttpConstant.TOKEN_EXPIRED));

      case HttpStatus.requestTimeout:
        return Future.value(ApiResponse(code: error.response?.statusCode, message: HttpConstant.TIME_OUT));

      case HttpStatus.badGateway:
        return Future.value(ApiResponse(code: error.response?.statusCode, message: HttpConstant.BAD_GATEWAY));

      default:
        return Future.value(ApiResponse(code: error.response?.statusCode, message: message));
    }
  }
}
