import 'package:domain/domain.dart';

import '../common/base_use_case.dart';

class GetAllPostUseCase extends BaseUseCase<ApiModel<List<PostModel>?>> {
  final WidgetRepository repository;

  GetAllPostUseCase({required this.repository});



  @override
  void validate() {}

  @override
  Future<ApiModel<List<PostModel>?>> invoke() {
    return repository.getAllPost();
  }
}
