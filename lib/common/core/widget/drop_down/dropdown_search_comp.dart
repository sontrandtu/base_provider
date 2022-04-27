import 'package:flutter/material.dart';
import 'package:overflow_view/overflow_view.dart';

class MultipleSelectedComp extends StatefulWidget {
  const MultipleSelectedComp({Key? key}) : super(key: key);

  @override
  State<MultipleSelectedComp> createState() => _MultipleSelectedCompState();
}

class _MultipleSelectedCompState extends State<MultipleSelectedComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: OverflowView(
          direction: Axis.horizontal,
          spacing: 4,
          children: <Widget>[
            for (int i = 0; i < 10; i++)
              Container(
                width: 50,
                height: 50,
                color: Colors.red,
              )
          ],
          builder: (context, remaining) {
            return Text('... $remaining');
          },
        ),
    );
  }
}
