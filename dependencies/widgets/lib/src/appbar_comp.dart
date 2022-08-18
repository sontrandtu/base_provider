import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'button/icon_button_comp.dart';

class AppBarComp extends PreferredSize {
  final dynamic title;
  final TextStyle? style;
  final List<Widget>? action;
  final Color? backgroundColor;
  final Color? colorIcon;
  final Color? colorTitle;
  final double? elevation;
  final double? height;
  final bool enableLeading;
  final bool enableFunctionLeading;
  final bool? centerTitle;
  final bool isLight;
  final Widget? flexibleSpace;
  final Widget? iconLeading;
  final Function? onLeading;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final PreferredSizeWidget? bottom;

  AppBarComp({
    Key? key,
    this.systemOverlayStyle,
    this.title = '',
    this.style,
    this.height,
    this.action,
    this.backgroundColor,
    this.colorIcon,
    this.elevation = 0,
    this.enableLeading = true,
    this.flexibleSpace,
    this.iconLeading,
    this.onLeading,
    this.centerTitle,
    this.bottom,
    this.enableFunctionLeading = true,
    this.isLight = true,
    this.colorTitle,
  }) : super(key: key, preferredSize: Size(double.infinity, height ?? kToolbarHeight), child: Container());

  @override
  Size get preferredSize => Size(double.infinity, height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        systemOverlayStyle:
            systemOverlayStyle ?? (isLight ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
        toolbarHeight: height,
        title: title is Widget
            ? title
            : Text(
                title,
                overflow: TextOverflow.ellipsis,
              ),
        titleTextStyle: style ?? TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: colorTitle),
        flexibleSpace: flexibleSpace ?? const SizedBox(),
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        leading: enableLeading
            ? iconLeading ??
                IconButtonComp(
                  icon: Icons.arrow_back_ios_rounded,
                  size: 20,
                  color: colorIcon ?? Colors.white,
                  onPress: () => _onBackPress(context),
                )
            : null,
        automaticallyImplyLeading: false,
        // leadingWidth: Navigator.canPop(context) ? null : 0,
        titleSpacing: 0,
        iconTheme: IconThemeData(color: colorIcon),
        centerTitle: centerTitle,
        actions: action,
        bottom: bottom,
      );

  void _onBackPress(BuildContext context) {
    if (enableFunctionLeading) if (enableLeading) Navigator.pop(context);
    onLeading?.call();
  }
}
