import 'package:achitech_weup/common/app_common.dart';
import 'package:achitech_weup/common/core/theme_manager.dart';
import 'package:achitech_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class BaseAppHeader extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? showBack;

  const BaseAppHeader({this.showBack = true,this.actions, this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: showBack?? true,
                child: InkWell(
                  onTap: () =>Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorResource.textBody,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(left: (showBack??true) ? 0.0 : 16.0),
                  child: Text(
                    title ?? '',
                    style: appStyle.textTheme.headline3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              ...actions ?? []
            ],
          ),
          Container(
            height: 1,
            color: ColorResource.divider,
          )
        ],
      ),
    );
  }
}
