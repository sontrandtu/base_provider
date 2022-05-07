import 'package:achitecture_weup/application.dart';
import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class StatelessProvider<VM extends BaseViewModel> extends StatelessWidget {
  VM get viewModel => Provider.of(navigator.currentContext!, listen: false);

  const StatelessProvider({Key? key}) : super(key: key);
}
