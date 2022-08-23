import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

main() async {
  await CacheStorage.ensureInitialized();
  var i;
  do {
    print('Nhập 1 để xem danh sách: ');
    print('Nhập 2 để thêm: ');
    print('Nhập 3 để xóa tài nguyên: ');
    print('Nhập 4 để xem tài nguyên: ');
    print('Lựa chọn: ');

    i = stdin.readLineSync();
    if (int.parse(i) == 1) await getAllFelling();
    if (int.parse(i) == 2) await addFelling();
    if (int.parse(i) == 3) await showLocalData();
    if (int.parse(i) == 4) await showAllLocalData();
  } while (int.parse(i) > 0);
}

showAllLocalData() {
  CacheStorage.show();
}

Future<void> showLocalData() async {
  print('Nhập key để xóa: ');
  var i = stdin.readLineSync();
  CacheStorage.delete(i ?? '');
}

Future<void> getAllFelling() async {
  ApiModel<List<FeelingModel>> response = await WidgetRepositoryImpl().getAllFeeling();
  print(response.runtimeType);
  print(response);
}

Future<void> addFelling() async {
  ApiModel response = await WidgetRepositoryImpl().addFeeling();
  print(response.runtimeType);
  print(response);
}
