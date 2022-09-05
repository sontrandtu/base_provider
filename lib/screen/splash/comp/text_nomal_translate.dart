import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TextNomalTranslate extends StatelessWidget {
  const TextNomalTranslate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(KeyLanguage.title.tr);
  }
}
