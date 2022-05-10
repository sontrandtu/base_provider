import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';

class ListTodoViewModel extends BaseViewModel {
  List<String> animatedList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];

  @override
  Future<void> initialData() async {
    setStatus(Status.success);
  }

  void insert() {
    animatedList.add('New Item ${animatedList.length}');
    update();
  }

  void remove() {
    animatedList.removeLast();
    update();
  }
}
