import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../common/constants.dart';


class HandleDioException<T> {
  DioError? error;

  HandleDioException(this.error);

  Future<ApiModel<T?>> catchError() {
    switch (error?.type) {
      case DioErrorType.response:
        return _okError();

      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
        return Future.value(ApiModel(code: CodeConstant.TIME_OUT,message: HttpConstant.TIME_OUT));

      default:
        return Future.value(ApiModel(code:CodeConstant.UNKNOWN,message:  HttpConstant.UNKNOWN));
    }
  }

  Future<ApiModel<T?>> _okError() {
    int? statusCode = error?.response?.statusCode;
    String? message = '$statusCode - ${error?.response?.statusMessage}';

    switch (statusCode) {
      case CodeConstant.FORBIDDEN:
        return Future.value(ApiModel(code:CodeConstant.FORBIDDEN,message: HttpConstant.FORBIDDEN));

      case CodeConstant.TOKEN_EXPIRED:
        return Future.value(
            ApiModel(code:CodeConstant.TOKEN_EXPIRED,message: HttpConstant.TOKEN_EXPIRED));

      case CodeConstant.TIME_OUT:
        return Future.value(ApiModel(code:CodeConstant.TIME_OUT,message: HttpConstant.TIME_OUT));

      case CodeConstant.BAD_GATEWAY:
        return Future.value(ApiModel(code:CodeConstant.BAD_GATEWAY,message: HttpConstant.BAD_GATEWAY));

      case CodeConstant.BAD_REQUEST:
        statusCode = error?.response?.data["code"];
        message = error?.response?.data["message"];
        return Future.value(ApiModel(code:statusCode!,message: message!));

      default:
        return Future.value(ApiModel(code:statusCode ?? CodeConstant.UNKNOWN,message: message));
    }
  }
}
