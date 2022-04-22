import 'package:achitecture_weup/system/model/post.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

@RestApi()
abstract class Service {
  factory Service(Dio dio) = _Service;

  @GET('/accounts')
  Future<HttpResponse<List<Post>>> getAllPost();
}
