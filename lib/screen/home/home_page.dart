import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/view/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, value, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ABC'),
            TextButtonComp(
              title: 'Back',
              onPressed: () => value.toggleMode(),
            ),
            ElevatedButtonComp(title: 'HHHHHHHH',onPressed: (){},)
          ],
        ),
      ),
    );
  }
}
