import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatefulWidget {
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? editingController;
  final TextStyle? style, hintStyle;
  final String? label;
  final String? hint;
  final String? error;
  final Function()? onTap;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final Function()? onComplete;
  final Function? onValidator;
  final bool? isReadOnly;
  final int? minLine, maxLines;
  final double? padH, padV, borderRadius;
  final TextCapitalization? capitalization;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? fillColor;
  final bool? enable;
  final BoxConstraints? suffixConstraint, prefixConstraint;
  final OutlineInputBorder? enabledBorder,
      focusedBorder,
      disableBorder,
      errorBorder,
      focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isDoubleNum;
  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final bool? isBorder;


  const BaseTextField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
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
    this.isDoubleNum, this.onFieldSubmitted, this.paddingSuffixIcon, this.paddingPrefixIcon, this.isBorder, this.enabledBorder, this.focusedBorder,
  }) : super(key: key);

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  Color? _labelColor;
  final Color _highColor = ColorResource.textBody;
  final Color _lowColor = ColorResource.textBody.withOpacity(0.5);
  final _textFormFieldKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() => _labelColor = hasFocus ? _highColor : _lowColor);
      },
      child: Form(
        key: _textFormFieldKey,
        child: TextFormField(
          controller: widget.editingController,
          enabled: widget.enable ?? true,
          onChanged: (String value) => widget.onChange,
          validator: (value) => widget.onValidator?.call(value),
          onEditingComplete: () => widget.onComplete,
          onTap: () => widget.onTap,
          onFieldSubmitted: (value) =>(value) => widget.onFieldSubmitted?.call(value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters ??
              ((widget.inputType == TextInputType.number)
                  ? (!widget.isDoubleNum!
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))])
                  : []),
          textCapitalization:
              widget.capitalization ?? TextCapitalization.sentences,
          textInputAction: widget.inputAction ?? TextInputAction.next,
          minLines: widget.minLine,
          maxLines: widget.maxLines,
          keyboardType: widget.inputType,
          textAlignVertical: TextAlignVertical.center,
          readOnly: widget.isReadOnly ?? false,
          style: widget.style ??
              appStyle.textTheme.bodyText1
                  ?.apply(color: ColorResource.textBody),
          decoration: inputDecoration(),
        ),
      ),
    );
  }

  InputDecoration inputDecoration()=>
     InputDecoration(
      errorStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
      filled: true,
      fillColor: widget.fillColor ?? Colors.white,
      labelText: widget.label ?? widget.hint,
      labelStyle: appStyle.textTheme.bodyText2?.apply(color: _labelColor),
      alignLabelWithHint: true,
      hintText: widget.hint,
      hintStyle: (widget.hintStyle ??
          appStyle.textTheme.bodyText2
              ?.apply(color: ColorResource.textBody.withOpacity(0.5))),
      contentPadding: widget.contentPadding ??
          EdgeInsets.symmetric(
            vertical: widget.padV ?? 16,
            horizontal: widget.padH ?? 8,
          ),
      isDense: true,
      prefixIcon: widget.prefixIcon,
      prefixIconConstraints: BoxConstraints(
        minWidth: widget.paddingPrefixIcon ?? 36,
        minHeight: widget.paddingPrefixIcon ?? 36,
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: widget.paddingSuffixIcon ?? 36,
        minHeight: widget.paddingSuffixIcon ?? 36,
      ),
      suffixIcon: widget.suffixIcon,
       enabledBorder: widget.isBorder!
           ? widget.enabledBorder ??
           OutlineInputBorder(
             borderSide:
             const BorderSide(width: 1, color: Colors.grey),
             borderRadius: BorderRadius.all(
               Radius.circular(widget.borderRadius ?? 8),
             ),
           )
           : null,
       focusedBorder: widget.isBorder!
           ? widget.focusedBorder ??
           OutlineInputBorder(
             borderSide:  BorderSide(
                 width: 1, color: ColorResource.primarySwatch),
             borderRadius: BorderRadius.all(
               Radius.circular(widget.borderRadius ?? 8),
             ),
           )
           : null,
       errorBorder: widget.isBorder!
           ? widget.errorBorder ??
           OutlineInputBorder(
             borderSide: const BorderSide(width: 1, color: Colors.red),
             borderRadius: BorderRadius.all(
               Radius.circular(widget.borderRadius ?? 8),
             ),
           )
           : null,
       focusedErrorBorder: widget.isBorder!
           ? widget.focusedErrorBorder ??
           OutlineInputBorder(
             borderSide: const BorderSide(width: 1, color: Colors.red),
             borderRadius: BorderRadius.all(
               Radius.circular(widget.borderRadius ?? 8),
             ),
           )
           : null,
    );
  }

