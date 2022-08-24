import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class ErrorLayout extends StatefulWidget {
  const ErrorLayout({Key? key}) : super(key: key);

  @override
  State<ErrorLayout> createState() => _ErrorLayoutState();
}

class _ErrorLayoutState extends State<ErrorLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: double.infinity,
            child: Text('Đã có lỗi xảy ra. Vui lòng thử lại sau', textAlign: TextAlign.center)),
        OutlinedButtonComp(title: 'Quay lại', onPressed: _onBackPress)
      ],
    );
  }

  void _onBackPress() {
    Navigator.maybePop(context);
  }
}
