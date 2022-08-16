// import 'package:weup/common/core/sys/api_response.dart';
// import 'package:weup/common/core/sys/base_use_case.dart';
// import 'package:weup/data/model/user_detail_model.dart';
// import 'package:weup/domain/repository/auth_repository.dart';
//
// class VerifyOtpRegisterUseCase extends BaseUseCase<ApiResponse> {
//   final UserDetailModel userDetailModel;
//   final AuthRepository repository;
//
//   VerifyOtpRegisterUseCase({required this.userDetailModel, required this.repository});
//
//   @override
//   Future<ApiResponse> invoke() async {
//     validate();
//
//     ApiResponse response = await repository.verifyOtpRegister(userDetailModel.toJson());
//
//     return response;
//   }
//
//   @override
//   void validate() {
//     notNullOrEmpty(userDetailModel.otp, name: 'otp');
//     notNullOrEmpty(userDetailModel.phone, name: 'phone');
//   }
// }
