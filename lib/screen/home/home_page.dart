import 'package:achitech_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: TextButtonComp(title: 'Back',onPressed: ()=>Navigator.pop(context),)));
  }
}
