import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:achitech_weup/common/app_common.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseTextField extends StatefulWidget {
  final Widget? widgetLeft, widgetRight, widgetAfterLeft;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? editingController;
  final TextStyle? style, hintStyle;
  final String? label;
  final String? hint;
  final String? error;
  final Function? onTap;
  final Function? onChange;
  final Function? onComplete;
  final bool? isReadOnly;
  final int? minLine, maxLines;
  final double? padH, padV, borderRadius;
  final TextCapitalization? capitalization;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? fillColor;
  final bool? enable;
  final Widget? widgetAbove, widgetBelow;
  final BoxConstraints? suffixConstraint, prefixConstraint;
  final OutlineInputBorder? enableBorder, focusBorder, disableBorder, errorBorder, focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Function? onValidator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isDoubleNum;

  const BaseTextField({
    Key? key,
    this.widgetLeft,
    this.widgetRight,
    this.widgetAfterLeft,
    this.widgetBelow,
    this.widgetAbove,
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
    this.focusBorder,
    this.enableBorder,
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
    return Expanded(
      flex: 1,
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() => _labelColor = hasFocus ? _highColor : _lowColor);
        },
        child: Form(
          key: _textFormFieldKey,
          child: TextFormField(
            controller: widget.editingController,
            enabled: widget.enable ?? true,
            onChanged: (String value) {
              widget.onChange?.call(value);
              if (_textFormFieldKey.currentState != null) {
                if (_textFormFieldKey.currentState!.validate()) {
                  _textFormFieldKey.currentState!.save();
                }
              }
            },
            validator: (value) => widget.onValidator?.call(value),
            onEditingComplete: () => widget.onComplete?.call(),
            onTap: () => widget.onTap?.call(),
            onFieldSubmitted: (_) {
              FocusScope.of(context).nextFocus();
              FocusScope.of(context).nextFocus();
            },
            inputFormatters: widget.inputFormatters ??
                ((widget.inputType == TextInputType.number)
                    ? (!widget.isDoubleNum!
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))])
                    : []),
            textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
            textInputAction: widget.inputAction ?? TextInputAction.next,
            minLines: widget.minLine,
            maxLines: widget.maxLines,
            keyboardType: widget.inputType,
            textAlignVertical: TextAlignVertical.center,
            readOnly: widget.isReadOnly ?? false,
            style: widget.style ?? appStyle.textTheme.bodyText1?.apply(color: ColorResource.textBody),
            decoration: InputDecoration(
              errorStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
              errorText: widget.error,
              errorMaxLines: 1,
              filled: true,
              fillColor: widget.fillColor ?? Colors.white,
              labelText: widget.label ?? widget.hint,
              labelStyle: appStyle.textTheme.bodyText2?.apply(color: _labelColor),
              alignLabelWithHint: true,
              hintText: widget.hint,
              hintStyle: (widget.hintStyle ??
                  appStyle.textTheme.bodyText2?.apply(color: ColorResource.textBody.withOpacity(0.5))),
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    vertical: widget.padV ?? 16,
                    horizontal: widget.padH ?? 8,
                  ),
              isDense: true,
              prefixIcon: widget.widgetLeft,
              prefixIconConstraints: widget.prefixConstraint ??
                  const BoxConstraints(
                    minHeight: 50,
                    maxWidth: 40,
                  ),
              suffixIconConstraints: widget.suffixConstraint ??
                  const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
              suffixIcon: widget.widgetRight,
            ),
          ),
        ),
      ),
    );
  }
}
