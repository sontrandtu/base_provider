import 'dart:io';
import 'package:achitech_weup/common/core/sys/base_response.dart';
import 'package:retrofit/retrofit.dart';

class BaseRepository {
  dynamic castData(HttpResponse response, {Function? cast}) {
    if (response.response.statusCode != HttpStatus.ok) return null;
    if (response.response.data == null) return null;
    if (cast == null) return response;

    return cast.call(BaseResponse.fromJson(response.response.data).data);
  }
}
