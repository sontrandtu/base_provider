import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:widgets/src/button/text_button_comp.dart';

import '../check_box/check_box_comp.dart';
import '../model_base/option_multiple_select.dart';

class MultipleSelectBottomSheet extends StatefulWidget {
  final Decoration? decoration;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final List<OptionMultipleSelect> listData;

  const MultipleSelectBottomSheet({
    Key? key,
    this.decoration,
    this.borderRadius = 12,
    this.backgroundColor,
    required this.listData,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  State<MultipleSelectBottomSheet> createState() => _MultipleSelectBottomSheetState();
}

class _MultipleSelectBottomSheetState extends State<MultipleSelectBottomSheet> {
  bool isShowSearch = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 16),
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.backgroundColor ?? Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                topRight: Radius.circular(widget.borderRadius),
              ),
            ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2.5,
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // driver(),
              // const SizedBox(height: 6),
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
                      Navigator.pop(
                        context,
                        widget.listData.where((element) => element.isCheck),
                      );
                    },
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.listData
                        .mapIndexed((index, element) => itemSelect(item: element, index: index))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget driver() => Container(
        height: 6,
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.7),
        ),
      );

  Widget itemSelect({required OptionMultipleSelect item, required int index}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: index == 0 ? 8 : 0,
          ),
          IntrinsicHeight(
            child: TextButtonComp(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  item.isCheck = !item.isCheck;
                });
              },
              child: Row(
                children: [
                  CheckBoxComp(
                    value: item.isCheck,
                    onChanged: (value) {
                      setState(() {
                        item.isCheck = !item.isCheck;
                      });
                    },
                    splashRadius: 0,
                  ),
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      );
}
