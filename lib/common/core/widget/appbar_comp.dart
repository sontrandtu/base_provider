import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'button/icon_button_comp.dart';

class AppBarComp extends PreferredSize {
  final dynamic title;
  final TextStyle? style;
  final List<Widget>? action;
  final Color? backgroundColor;
  final Color? colorIcon;
  final double? elevation;
  final bool? isLight;
  final bool? isLeading;
  final Widget? flexibleSpace;
  final Widget? iconLeading;
  final Function? onLeading;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final PreferredSizeWidget? bottom;

  AppBarComp({
    Key? key,
    this.systemOverlayStyle,
    this.title,
    this.style,
    this.action,
    this.backgroundColor,
    this.colorIcon,
    this.elevation = 0,
    this.isLight,
    this.isLeading = true,
    this.flexibleSpace,
    this.iconLeading,
    this.onLeading,
    this.bottom,
  }) : super(key: key, preferredSize: const Size(double.infinity, kToolbarHeight), child: Container());

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.light,
        title: title is Widget
            ? title
            : Text(
                title,
                style: style ?? const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
        flexibleSpace: flexibleSpace ?? Container(),
        backgroundColor: backgroundColor,
        leading: iconLeading ??
            IconButtonComp(
              icon: Icons.arrow_back_rounded,
              size: 26,
              color: Colors.white,
              onPress: () => _onBackPress(context),
              splashRadius: 26,
            ),
        iconTheme: IconThemeData(color: colorIcon),
        actions: action,
        bottom: bottom,
      );

  void _onBackPress(BuildContext context) {
    if (onLeading == null) Navigator.pop(context);

    onLeading?.call();
  }
}
