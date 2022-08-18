import 'package:domain/domain.dart';

class WidgetRepositoryImpl implements WidgetRepository {
  WidgetRepositoryImpl._internal();

  static final WidgetRepositoryImpl _instance = WidgetRepositoryImpl._internal();

  factory WidgetRepositoryImpl() => _instance;

  @override
  Future getShareApp() {
    throw UnimplementedError();
  }
}
