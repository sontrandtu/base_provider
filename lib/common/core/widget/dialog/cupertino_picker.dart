import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/theme/theme_manager.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helper/view_utils.dart';

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
    return SizedBox(
      height: ViewUtils.height * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButtonComp(
                title: KeyLanguage.cancel.tl,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButtonComp(
                title: KeyLanguage.confirm.tl,
                onPressed: () {
                  Navigator.pop(context, dateTime);
                },
                style: appStyle.textTheme.headline4!
                    .apply(color: ColorResource.primarySwatch),
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
      ),
    );
  }
}
