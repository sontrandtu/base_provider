import 'package:state/state.dart';

class SplashViewModel extends BaseViewModel {
  @override
  Future<void> initialData() async {
    await fetchData();
  }

  @override
  Future<void> fetchData() async {
    // if (await isConnecting) return;
    // await delay(1000);
    // ApiModel<List<PostModel>?> response =
    //     await GetAllPostUseCase(repository: WidgetRepositoryImpl()).invoke();
    // print(response);
    // if (checkStatus(ApiModel(code: CodeConstant.OK, message: HttpConstant.UNKNOWN))) return;
    setStatus(Status.success);
  }

  void test() {
    notifyListeners();
  }
}
