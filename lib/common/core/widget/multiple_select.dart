import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/widget/bottom_sheet/multiple_selec_bottomsheet.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:collection/collection.dart';

class MultipleSelectComp<T> extends StatefulWidget {
  final Function(List<OptionMultipleSelect<T>> listValue) onChange;
  final List<OptionMultipleSelect<T>> listItems;

  const MultipleSelectComp(
      {Key? key, required this.onChange, required this.listItems})
      : super(key: key);

  @override
  State<MultipleSelectComp<T>> createState() => _MultipleSelectCompState();
}

class _MultipleSelectCompState<T> extends State<MultipleSelectComp<T>> {
  List<OptionMultipleSelect<T>> listDataSelected = [];


  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      paddingAll: 0,
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => MultipleSelectBottomSheet(
          listData: widget.listItems,
        ),
      ).then((value) {
        if (value != null) {
          setState(() {
            listDataSelected.clear();
            listDataSelected.addAll(value);
            widget.onChange(listDataSelected);
          });
        }
      }),
      isTransparent: true,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.4)),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: listDataSelected.isNotEmpty
                    ? OverflowView.flexible(
                        direction: Axis.horizontal,
                        children: listDataSelected
                            .mapIndexed((index, element) =>
                                itemSelected(element.title, index))
                            .toList(),
                        builder: (context, remaining) {
                          return Row(
                            children: [
                              const SizedBox(width: 6),
                              const Text('...'),
                              itemSelected('+ $remaining', 1),
                            ],
                          );
                        },
                      )
                    : const Text('Chose value'),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded)
            ],
          )),
    );
  }

  Widget itemSelected(String title, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: EdgeInsets.only(left: index == 0 ? 0 : 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorResource.primarySwatch,
      ),
      child: Text(
        title,
        style: appStyle.textTheme.bodyText2!.apply(color: Colors.white),
      ),
    );
  }
}
