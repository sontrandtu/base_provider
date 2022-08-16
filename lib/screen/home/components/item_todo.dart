import 'package:flutter/material.dart';

class ItemTodo extends StatelessWidget {
  final String? s;
  final Animation<double>? animation;

  const ItemTodo({Key? key, this.s, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation!,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Text(s ?? ''),
      ),
    );
  }
}
