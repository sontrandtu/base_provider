import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


showDatePickerDialog(BuildContext context) {
  showDialog(context: context, builder: (context) => const DatePickerComp());
}

class DatePickerComp extends StatelessWidget {
  const DatePickerComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appStyle.backgroundColor
      ),
      width: double.infinity*3/4,
      height: double.infinity/2,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child:SfDateRangePicker(),
    );
  }
}


