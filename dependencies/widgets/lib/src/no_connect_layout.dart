import 'package:flutter/material.dart';
import 'package:widgets/src/button/outlined_button_comp.dart';
import 'package:widgets/src/indicator_comp.dart';

typedef OnReconnect = Future<void> Function();

class NoConnectLayout extends StatefulWidget {
  const NoConnectLayout({Key? key, this.onReconnect}) : super(key: key);
  final OnReconnect? onReconnect;

  @override
  State<NoConnectLayout> createState() => _NoConnectLayoutState();
}

class _NoConnectLayoutState extends State<NoConnectLayout> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity,child: Text('Không có kết nối internet',textAlign: TextAlign.center,)),
        OutlinedButtonComp(
          width: 100,
          title: _isLoading ? SizedBox(height: 18,width: 18,child: IndicatorComp()) : 'Thử lại',
          isEnable: !_isLoading,
          onPressed: _onReconnect,
        )
      ],
    );
  }

  void _onReconnect() async {
    setLoading(true);
    await widget.onReconnect?.call();
    await Future.delayed(Duration(seconds: 3));
    setLoading(false);
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    if(mounted)setState(() {});
  }
}
