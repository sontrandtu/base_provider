import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/value_listenable_builder.dart';
import 'package:provider/provider.dart';

class SelectorBase extends Selector{
  SelectorBase({required ValueWidgetBuilder builder, required Function(BuildContext p1, dynamic p2) selector}) : super(builder: builder, selector: selector);

}