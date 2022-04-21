import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/sys/base_state.dart';
import 'package:achitech_weup/main.dart';
import 'package:achitech_weup/screen/splash/splash_view_model.dart';
import 'package:achitech_weup/system/model/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<SplashPage, SplashViewModel> {
  @override
  void setViewModel() => viewModel = splashViewModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<SplashViewModel>(
        builder: (_, provider, __) => DropKeyboard(
          status: provider.status,
          child: Column(
            children: [
              TextButtonComp(title: 'Click me',onPressed: ()=> Navigator.pushNamed(context,RoutePath.login,arguments: Post(title: '123123',id: 1)),),
              Expanded(child: ListView.builder(itemBuilder: _buildItem,itemCount: provider.posts.length,))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    Post post = viewModel.posts[index];
    return InkWell(onTap: ()=> null,child: Container(padding: EdgeInsets.all(8),child: Text(post.title ?? ''),));
  }
}
