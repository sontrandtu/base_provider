import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseAppBar extends PreferredSize {
  final String? title;
  final TextStyle? style;
  final List<Widget>? action;
  final Color? backgroundColor;
  final Color? colorIcon;
  double? elevation = 0;
  final bool? isLight;
  bool? isLeading = true;
  final Widget? flexibleSpace;
  final Icon? iconLeading;
  final Function? onLeading;
  final SystemUiOverlayStyle? systemOverlayStyle;

  BaseAppBar({
    Key? key,
    this.systemOverlayStyle,
    this.title,
    this.style,
    this.action,
    this.backgroundColor,
    this.colorIcon,
    this.elevation,
    this.isLight,
    this.isLeading,
    this.flexibleSpace,
    this.iconLeading,
    this.onLeading,
  }) : super(
            key: key,
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: Container());

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.light,
      title: Text(
        title ?? '',
        style: style ?? const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      flexibleSpace: flexibleSpace ?? Container(),
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: onLeading != null
          ? iconLeading ??
              IconButton(
                  splashRadius: 26,
                  onPressed: () => onLeading?.call() ?? Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded, size: 26, color: Colors.white))
          : const SizedBox(),
      iconTheme: IconThemeData(color: colorIcon),
      actions: action);
}
