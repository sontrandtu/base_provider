import 'package:achitech_weup/common/core/widget/base_text_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var ted1=TextEditingController();
  var ted2=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BaseTextField(
            hint: 'Test1',
            editingController: ted1,
          ),

        ],
      ),
    );
  }
}
