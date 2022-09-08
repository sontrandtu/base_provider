import 'package:state/src/nav_obs.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:state/state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    showError(LifecycleBase.settings);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
