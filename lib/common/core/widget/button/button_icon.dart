import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final IconData? icon;
  final Function? onClick;

  const ButtonIcon({this.icon, this.onClick, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClick?.call(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            icon,
            color: ColorResource.textBody,
            size: 20,
          ),
        ),
      ),
    );
  }
}
