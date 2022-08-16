import 'package:achitecture_weup/common/core/widget/input/button_obscure.dart';
import 'package:flutter/material.dart';

import '../../../resource/color_resource.dart';
import '../../theme/theme_manager.dart';

class UnderlineInput extends StatefulWidget {
  const UnderlineInput(
      {Key? key,
      this.controller,
      this.contentPadding,
      this.prefixIcon,
      this.suffixIcon,
      this.hintStyle,
      this.labelStyle,
      this.labelText,
      this.hintText,
      this.fillColor,
      this.onTap,
      this.onValidator,
      this.onFieldSubmitted,
      this.onChanged,
      this.obscureText})
      : super(key: key);
  final TextEditingController? controller;

  final EdgeInsetsGeometry? contentPadding;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  final String? labelText;
  final String? hintText;

  final Color? fillColor;

  final bool? obscureText;

  final GestureTapCallback? onTap;
  final String? Function(String? s)? onValidator;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onChanged;

  @override
  State<UnderlineInput> createState() => _UnderlineInputState();
}

class _UnderlineInputState extends State<UnderlineInput> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: widget.controller ?? TextEditingController(),
      onChanged: widget.onChanged,
      validator: widget.onValidator,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      style: appStyle.textTheme.bodyText1?.apply(color: ColorResource.primarySwatch),
      decoration: inputDecoration(),
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
        errorStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
        filled: false,
        fillColor: widget.fillColor,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        hintText: widget.hintText,
        hintStyle: (widget.hintStyle ?? appStyle.textTheme.bodyText1),
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffixIcon(),
        prefixIconConstraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        suffixIconConstraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 1, color: ColorResource.divider),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorResource.primarySwatchMaterial),
            borderRadius: BorderRadius.circular(8)),
        errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
      );

  Widget? _suffixIcon() {
    if (widget.obscureText ?? false) {
      return ButtonObscure(isObscure: isObscure, onObscureChange: _onObscureChange);
    }
    return widget.suffixIcon;
  }

  void _onObscureChange() {
    isObscure = !isObscure;
    setState(() {});
  }
}
