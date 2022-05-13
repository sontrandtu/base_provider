import 'package:achitecture_weup/system/model/post.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi()
abstract class Service {
  factory Service(Dio dio) = _Service;

  @GET('/comments')
  Future<HttpResponse<List<Post>?>> getAllComments(@Queries() Map<String,dynamic> m);
}
