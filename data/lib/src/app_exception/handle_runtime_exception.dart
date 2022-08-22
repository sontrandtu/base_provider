import 'package:domain/domain.dart';

import '../common/constants.dart';

class HandleRuntimeException<T> {
  Object? error;

  HandleRuntimeException(this.error);

  Future<ApiModel<T>> catchError() {
    return Future.value(ApiModel(code: CodeConstant.UNKNOWN, message: HttpConstant.UNKNOWN));
  }
}
