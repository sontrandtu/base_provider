import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

main() async {
  var i;
  do {
    ApiModel<List<FeelingModel>> response = await WidgetRepositoryImpl().getAllFeeling();
    print(response.runtimeType);
    print(response);
    response.data?.forEach((element) {
      print(element.id);
    });
    print(RequestCacheManager().get('/v1/lesson-contact-comment/1654649615pa1g8zjyf79v-GET-{token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwaG9uZSI6IjA5NDM1NzQ1NTYifQ.LrOc2ZA-vE_vuQm-J8bjxPMQF7C8AkLyqnhVZiPEXuE, id: 1660546372487t40li80k3}'));
    i = stdin.readLineSync();
  } while (i == '0');
}
