import 'package:flutter/material.dart';

import 'button_obscure.dart';

class OutlineInput extends StatefulWidget {
  const OutlineInput(
      {Key? key,
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
      this.controller,
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
  State<OutlineInput> createState() => _OutlineInputState();
}

class _OutlineInputState extends State<OutlineInput> {
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
      style: Theme.of(context).textTheme.bodyText1?.apply(color: Theme.of(context).primaryColor),
      decoration: inputDecoration(),
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
        errorStyle: Theme.of(context).textTheme.bodyText2?.apply(color: Colors.red),
        filled: true,
        fillColor: widget.fillColor,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        hintText: widget.hintText,
        hintStyle: (widget.hintStyle ?? Theme.of(context).textTheme.bodyText1),
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffixIcon(),
        prefixIconConstraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        suffixIconConstraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(8)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.red),
            borderRadius: BorderRadius.circular(8)),
        focusedErrorBorder: OutlineInputBorder(
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
