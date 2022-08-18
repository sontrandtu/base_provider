import 'package:dio/dio.dart';
class HandleDioException<T> {
  DioError? error;

  HandleDioException(this.error);
  //
  // Future<ApiResponse<T?>> catchError() {
  //   switch (error?.type) {
  //     case DioErrorType.response:
  //       return _okError();
  //
  //     case DioErrorType.sendTimeout:
  //     case DioErrorType.connectTimeout:
  //     case DioErrorType.receiveTimeout:
  //       return Future.value(ApiResponse(err: ErrorCode(CodeConstant.TIME_OUT, HttpConstant.TIME_OUT)));
  //
  //     default:
  //       return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, HttpConstant.UNKNOWN)));
  //   }
  // }
  //
  // Future<ApiResponse<T?>> _okError() {
  //   int? statusCode = error?.response?.statusCode;
  //   String? message = '$statusCode - ${error?.response?.statusMessage}';
  //
  //   switch (statusCode) {
  //     case CodeConstant.FORBIDDEN:
  //       return Future.value(ApiResponse(err: ErrorCode(CodeConstant.FORBIDDEN, HttpConstant.FORBIDDEN)));
  //
  //     case CodeConstant.TOKEN_EXPIRED:
  //       return Future.value(
  //           ApiResponse(err: ErrorCode(CodeConstant.TOKEN_EXPIRED, HttpConstant.TOKEN_EXPIRED)));
  //
  //     case CodeConstant.TIME_OUT:
  //       return Future.value(ApiResponse(err: ErrorCode(CodeConstant.TIME_OUT, HttpConstant.TIME_OUT)));
  //
  //     case CodeConstant.BAD_GATEWAY:
  //       return Future.value(ApiResponse(err: ErrorCode(CodeConstant.BAD_GATEWAY, HttpConstant.BAD_GATEWAY)));
  //
  //     case CodeConstant.BAD_REQUEST:
  //       statusCode = error?.response?.data["code"];
  //       message = error?.response?.data["message"];
  //       return Future.value(ApiResponse(err: ErrorCode(statusCode!, message!)));
  //
  //     default:
  //       return Future.value(ApiResponse(err: ErrorCode(statusCode ?? CodeConstant.UNKNOWN, message)));
  //   }
  // }
}
