
class HandleRuntimeException<T> {
  Object? error;

  HandleRuntimeException(this.error);

  // Future<ApiResponse<T>> catchError() {
  //   return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, HttpConstant.UNKNOWN)));
  // }
}
