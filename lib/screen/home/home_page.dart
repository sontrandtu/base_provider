import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/main.dart';
import 'package:achitech_weup/screen/home/home_view_model.dart';
import 'package:achitech_weup/view/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage,HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder:(context, child) =>  Consumer<HomeViewModel>(
        builder: (context, value, child) => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('ABC',style: appStyle.textTheme.bodyText2,),
              TextButtonComp(
                title: 'Back',
                onPressed: () => themeViewModel.toggleMode(),
              ),
              ElevatedButtonComp(title: 'HHHHHHHH',onPressed: (){},)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initViewModel() => viewModel = HomeViewModel();
}
