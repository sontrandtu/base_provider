import 'package:achitecture_weup/common/core/sys/base_option_dropdown.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class DropdownComp extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? currentValue, hint, error, label;
  final int? index;
  final List<BaseOptionDropdown>? listItems;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final double? borderRadius;
  final Function? onValidator;
  final Function? onTapCallBack;
  final TextStyle? hintStyle;
  final TextStyle? selectionStyle;
  final TextStyle? selectedStyle;
  final bool? isCollapsed;
  final bool? isBorder;
  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final EdgeInsetsGeometry? contentPadding;

// cach mot khoang le ben trai mac dinh
  final bool? filled;
  final Color? bgSelection;
  final Color? bgSelected;

  final GlobalKey dropdownKey = GlobalKey();
  final _dropdownFormFieldKey = GlobalKey<FormState>();

  DropdownComp({
    Key? key,
    this.prefixIcon,
    this.currentValue,
    this.hint,
    this.index,
    this.listItems,
    this.borderRadius,
    this.onTapCallBack,
    this.errorBorder,
    this.focusedErrorBorder,
    this.error,
    this.onValidator,
    this.label,
    this.suffixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.isCollapsed = false,
    this.isBorder = false,
    this.paddingSuffixIcon,
    this.paddingPrefixIcon,
    this.contentPadding,
    this.filled,
    this.hintStyle,
    this.selectionStyle,
    this.selectedStyle,
    this.bgSelection,
    this.bgSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => (listItems?.length ?? -1) > 0
            ? openDropdownAnyWhere()
            : FocusScope.of(context).unfocus(),
        child: Focus(
          onFocusChange: (hasFocus) {},
          child: Form(
            key: _dropdownFormFieldKey,
            child: Container(
              decoration: BoxDecoration(
                  color: bgSelected ?? Colors.white,
                  borderRadius: isBorder!
                      ? BorderRadius.all(
                          Radius.circular(borderRadius ?? 8),
                        )
                      : null),
              child: DropdownButtonFormField(
                dropdownColor: bgSelection ?? Colors.white,
                decoration: border(),
                validator: (value) => onValidator?.call(value),
                key: dropdownKey,
                menuMaxHeight: height / 2,
                value: currentValue == '' ? null : currentValue,
                isExpanded: true,
                isDense: false,
                onTap: () => FocusScope.of(context).unfocus(),
                onChanged: (value) {
                  if (_dropdownFormFieldKey.currentState != null) {
                    if (_dropdownFormFieldKey.currentState!.validate()) {
                      _dropdownFormFieldKey.currentState!.save();
                    }
                  }
                },
                items: listItems!.map((value) {
                  return DropdownMenuItem(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      onTapCallBack?.call(value, index ?? 0);
                    },
                    value: value,
                    child: Text(
                      value.name ?? '',
                      style: selectionStyle,
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) => listItems!
                    .map(
                      (value) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.name ?? '',
                          style: selectedStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration border() {
    return !isCollapsed!
        ? InputDecoration(
            hintStyle: hintStyle,
            hintText: hint,
            errorText: error,
            label: label != null ? Text(label ?? '') : null,
            labelStyle: TextStyle(color: ColorResource.primary),
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(
              minWidth: paddingSuffixIcon ?? 36,
              minHeight: paddingSuffixIcon ?? 36,
            ),
            prefixIcon: prefixIcon,
            prefixIconConstraints: BoxConstraints(
              minWidth: paddingPrefixIcon ?? 36,
              minHeight: paddingPrefixIcon ?? 36,
            ),
            contentPadding: contentPadding,
            filled: filled,
            fillColor: Colors.red,
            enabledBorder: isBorder!
                ? enabledBorder ??
                    OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : null,
            focusedBorder: isBorder!
                ? focusedBorder ??
                    OutlineInputBorder(
                      borderSide:
                           BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : null,
            errorBorder: isBorder!
                ? errorBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : null,
            focusedErrorBorder: isBorder!
                ? focusedErrorBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : null,
          )
        : InputDecoration.collapsed(
            hintStyle: hintStyle,
            hintText: hint,
          );
  }

  openDropdownAnyWhere() {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget != null && element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
          return;
        } else {
          searchForGestureDetector(element);
        }
        return;
      });
    }

    searchForGestureDetector(dropdownKey.currentContext!);
    detector!.onTap!();
  }
}
