import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComp(
        title: 'App',
        onLeading: () {},
      ),
      body: const ImageViewer(
        // 'https://hoithanh.com/wp-content/uploads/2015/07/b7433357-de29-4381-9cd4-9c2b8882f4c0.jpg',
        'assets/images/pdf.png',
        hasViewImage: true,
      ),
    );
  }
}
