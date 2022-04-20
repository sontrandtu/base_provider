import 'package:flutter/material.dart';

class DropOverlay extends StatelessWidget {
  const DropOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>Navigator.pop(context),
        child:  Container(color: Colors.transparent,),
      ),
    );
  }
}
