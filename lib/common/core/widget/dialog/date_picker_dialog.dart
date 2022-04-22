import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/helper/app_common.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePickerComp extends StatelessWidget {
  final DateRangePickerView? view;
  final DateRangePickerSelectionMode? selectionMode;
  final List? banDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool? allowViewNavigation;
  final bool? enablePastDates;

  const DatePickerComp({
    Key? key,
    this.view,
    this.allowViewNavigation,
    this.selectionMode,
    this.banDate,
    this.minDate,
    this.maxDate,
    this.enablePastDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ViewUtils.height * 0.21,
        horizontal: ViewUtils.width * 0.05,
      ),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: appStyle.backgroundColor,
          borderRadius: BorderRadius.circular(12)),
      child: SfDateRangePicker(
        view: view ?? DateRangePickerView.year,
        allowViewNavigation: allowViewNavigation ?? false,
        showActionButtons: true,
        selectionMode: selectionMode ?? DateRangePickerSelectionMode.single,
        showNavigationArrow: true,
        minDate: minDate,
        maxDate: maxDate,
        enablePastDates: enablePastDates ?? true,
        viewSpacing: 15,
        selectableDayPredicate: (DateTime value) {
          bool ban = true;
          if (banDate != null) {
            for (var element in banDate!) {
              if (value.weekday == element) {
                ban = false;
              }
            }
          }
          return ban;
        },
        onSubmit: (Object? value) {
          Navigator.pop(context, value);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
