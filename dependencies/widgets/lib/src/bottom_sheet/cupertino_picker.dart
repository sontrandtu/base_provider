import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';
import 'package:widgets/src/button/text_button_comp.dart';

class CupertinoPickerDialog extends StatefulWidget {
  final int? minimumYear, maximumYear;
  final DateTime? minimumDate, maximumDate, initialDateTime;
  final CupertinoDatePickerMode? mode;

  const CupertinoPickerDialog({
    Key? key,
    this.minimumYear,
    this.maximumYear,
    this.minimumDate,
    this.maximumDate,
    this.initialDateTime,
    this.mode,
  }) : super(key: key);

  @override
  State<CupertinoPickerDialog> createState() => _CupertinoPickerDialog();
}

class _CupertinoPickerDialog extends State<CupertinoPickerDialog> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButtonComp(
              title: KeyLanguage.cancel.tr,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButtonComp(
              title: KeyLanguage.confirm.tr,
              onPressed: () {
                Navigator.pop(context, dateTime);
              },
              // style: appStyle.textTheme.headline4!
              //     .apply(color: ColorResource.primarySwatch),
            )
          ],
        ),
        Expanded(
          child: CupertinoDatePicker(
            mode: widget.mode ?? CupertinoDatePickerMode.date,
            use24hFormat: true,
            minimumYear: widget.minimumYear ?? 1,
            maximumYear: widget.maximumYear,
            maximumDate: widget.maximumDate,
            minimumDate: widget.minimumDate,
            initialDateTime: widget.initialDateTime ?? dateTime,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                dateTime = newDate;
              });
            },
          ),
        ),
      ],
    );
  }
}
