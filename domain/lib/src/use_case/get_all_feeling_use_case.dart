import 'package:domain/domain.dart';

import '../common/base_use_case.dart';

class GetAllFeelingUseCase extends BaseUseCase<ApiModel<List<FeelingModel>?>> {
  final WidgetRepository repository;

  GetAllFeelingUseCase({required this.repository});



  @override
  void validate() {}

  @override
  Future<ApiModel<List<FeelingModel>?>> invoke() {
    return repository.getAllFeeling();
  }
}
