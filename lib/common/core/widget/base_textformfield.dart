import 'package:achitech_weup/common/app_common.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

@immutable
class BaseTextFormField extends StatelessWidget {
  final TextEditingController editingController;
  final Function(String value)? onChange;
  final bool? readOnly;
  final bool? enable;
  final TextInputType? textInputType;
  final int? maxLines;
  final Icon? headIcon;
  final Function(String value)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTab;
  final String? hint, label, error;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final TextStyle? hintStyle;
  final int? maxLength;
  final double? borderRadius;
  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? icon;
  final EdgeInsetsGeometry? contentPadding;
  final bool? obscureText;

  // cach mot khoang le ben trai mac dinh
  final bool? filled;
  final Color? bg;

  // giam chieu cao mac dinh cua texfield
  final bool? isDense;
  final bool? isBorder;

  // textField khong con gach chan va khoang cach
  final bool? isCollapsed;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;

  const BaseTextFormField({
    required this.editingController,
    this.onChange,
    this.maxLines,
    this.readOnly,
    this.error,
    this.headIcon,
    this.enable,
    this.textInputType,
    Key? key,
    this.hint,
    this.label,
    this.focusNode,
    this.textInputAction,
    this.textCapitalization,
    this.hintStyle,
    this.maxLength,
    this.borderRadius,
    this.paddingSuffixIcon,
    this.paddingPrefixIcon,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.obscureText,
    this.bg,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTab,
    this.icon,
    this.isDense,
    this.isBorder = false,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.filled,
    this.isCollapsed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      controller: editingController,
      readOnly: readOnly ?? false,
      enabled: enable ?? true,
      maxLines: maxLines ?? 1,
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.done,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      decoration: border(),
      onChanged: (value) => onChange?.call(value),
      onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
      onEditingComplete: () => onEditingComplete,
      onTap: () => onTab,
    );
  }

  InputDecoration border() {
    return !isCollapsed!
        ? InputDecoration(
            hintStyle: hintStyle,
            hintText: hint,
            errorText: error,
            label: label != null ? Text(label ?? '') : null,
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
            contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 8,horizontal: 0),
            filled: filled,
            fillColor: bg ?? Colors.white,
            icon: icon,
            isDense: isDense,
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
                      borderSide: const BorderSide(
                          width: 1, color: ColorResource.primary),
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
            fillColor: bg,
          );
  }
}
