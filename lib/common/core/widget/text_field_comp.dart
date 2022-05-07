import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComp extends StatefulWidget {
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? editingController;
  final TextStyle? style, hintStyle, labelStyle;
  final String? label;
  final String? hint;
  final String? error;
  final Function()? onTap;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final Function()? onComplete;
  final Function? onValidator;

  final int? minLine, maxLines;
  final double? padH, padV, borderRadius;
  final TextCapitalization? capitalization;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? fillColor;
  final bool? enable;
  final BoxConstraints? suffixConstraint, prefixConstraint;
  final OutlineInputBorder? enabledBorder, focusedBorder, disableBorder, errorBorder, focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final bool? isBorder;
  final bool? isUnderLine;
  final bool? isDoubleNum;
  final bool? isReadOnly;

  final bool? isInvisiblePassword;

  const TextFieldComp({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.isInvisiblePassword = false,
    this.editingController,
    this.hint,
    this.onChange,
    this.onComplete,
    this.onTap,
    this.isReadOnly,
    this.minLine,
    this.maxLines,
    this.padH,
    this.padV,
    this.capitalization,
    this.backgroundColor,
    this.borderColor,
    this.suffixConstraint,
    this.focusedErrorBorder,
    this.errorBorder,
    this.disableBorder,
    this.fillColor,
    this.inputAction,
    this.error,
    this.label,
    this.enable,
    this.borderRadius,
    this.contentPadding,
    this.inputFormatters,
    this.hintStyle,
    this.onValidator,
    this.prefixConstraint,
    this.style,
    this.isDoubleNum,
    this.onFieldSubmitted,
    this.paddingSuffixIcon,
    this.paddingPrefixIcon,
    this.isBorder = false,
    this.enabledBorder,
    this.focusedBorder,
    this.isUnderLine = false,
    this.labelStyle,
  }) : super(key: key);

  @override
  State<TextFieldComp> createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp> {
  final _textFormFieldKey = GlobalKey<FormState>();
  bool obscureText = false;
  Widget? suffixIcon = const SizedBox();

  @override
  void initState() {
    super.initState();
    suffixIcon = widget.suffixIcon;
    if (widget.isInvisiblePassword!) {
      obscureText = true;
      suffixIcon =  InkWellComp(
          isTransparent: true,onTap: _changeObscure, child: const Icon(Icons.remove_red_eye,size: 24,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _textFormFieldKey,
      child: TextFormField(
        controller: widget.editingController,
        enabled: widget.enable ?? true,
        obscureText: obscureText,
        onChanged: (String value) => widget.onChange,
        validator: (value) => widget.onValidator?.call(value),
        onEditingComplete: () => widget.onComplete,
        onTap: () => widget.onTap,
        onFieldSubmitted: (value) => (value) => widget.onFieldSubmitted?.call(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: widget.inputFormatters ??
            ((widget.inputType == TextInputType.number)
                ? (!widget.isDoubleNum!
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))])
                : []),
        textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
        textInputAction: widget.inputAction ?? TextInputAction.next,
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLines ?? 1,
        keyboardType: widget.inputType,
        textAlignVertical: TextAlignVertical.center,
        readOnly: widget.isReadOnly ?? false,
        style: widget.style ?? appStyle.textTheme.bodyText1,
        decoration: inputDecoration(),
      ),
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
        errorStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
        filled: true,
        fillColor: widget.fillColor,
        labelText: widget.label ?? widget.hint,
        labelStyle: widget.labelStyle,
        alignLabelWithHint: true,
        hintText: widget.hint,
        hintStyle: (widget.hintStyle ?? appStyle.textTheme.bodyText2),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              vertical: widget.padV ?? 16,
              horizontal: widget.padH ?? 12,
            ),
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.paddingPrefixIcon ?? 36,
          minHeight: widget.paddingPrefixIcon ?? 36,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: widget.paddingSuffixIcon ?? 36,
          minHeight: widget.paddingSuffixIcon ?? 36,
        ),
        enabledBorder: widget.isBorder!
            ? widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: ColorResource.divider),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
        focusedBorder: widget.isBorder!
            ? widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: ColorResource.primarySwatchMaterial,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
        errorBorder: widget.isBorder!
            ? widget.errorBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
        focusedErrorBorder: widget.isBorder!
            ? widget.focusedErrorBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
      );

  void _changeObscure() {
    obscureText = !obscureText;

    suffixIcon = InkWellComp(
      isTransparent: true,
        onTap: _changeObscure, child: Icon(obscureText ? Icons.remove_red_eye : Icons.visibility_off,size: 24,));
    setState(() {});
  }
}
