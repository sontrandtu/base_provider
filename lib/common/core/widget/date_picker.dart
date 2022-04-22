import 'package:flutter/material.dart';

class DatePickerComp extends StatelessWidget {
  const DatePickerComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DatePickerDialog(
      initialDate: DateTime.now(),
      firstDate: DateTime(1975),
      lastDate: DateTime(3000),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
  }
}
