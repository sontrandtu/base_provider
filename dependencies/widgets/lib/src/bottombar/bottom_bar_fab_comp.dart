import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets/src/button/floating_action_button_comp.dart';
import 'package:widgets/src/radio/radio_custom_comp.dart';

import 'painter_bottombar.dart';

class BottomBarFabComp extends StatelessWidget {
  final Function(int value) onChangeTab;
  final Function onPressedFAB;
  final Widget body;

  const BottomBarFabComp(
      {Key? key, required this.onChangeTab, required this.body, required this.onPressedFAB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          FloatingActionButtonComp(child: const Icon(CupertinoIcons.add), onPressed: onPressedFAB),
      bottomNavigationBar: BottomAppBarComp(onChangeTab: (int value) => onChangeTab.call(value)),
    );
  }
}

class BottomAppBarComp extends StatefulWidget {
  final Function(int value) onChangeTab;

  const BottomAppBarComp({Key? key, required this.onChangeTab}) : super(key: key);

  @override
  State<BottomAppBarComp> createState() => _BottomAppBarCompState();
}

class _BottomAppBarCompState extends State<BottomAppBarComp> {
  List<int> tabValue = [1, 2, 3, 4];
  int tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: BottomAppBar(
        shape: const CircularBottomBar(leftCornerRadius: 16, rightCornerRadius: 16),
        notchMargin: 8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: itemBottomBar(
                valueTab: tabValue[0],
                iconData: Icons.menu,
                title: 'Menu',
                onChangeTab: () => widget.onChangeTab.call(tabValue[0]),
              ),
            ),
            Expanded(
              child: itemBottomBar(
                valueTab: tabValue[1],
                iconData: Icons.menu,
                title: 'Menu',
                onChangeTab: () => widget.onChangeTab.call(tabValue[1]),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Text(
                      'Add',
                      style:
                          Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: itemBottomBar(
                valueTab: tabValue[2],
                iconData: Icons.menu,
                title: 'Menu',
                onChangeTab: () => widget.onChangeTab.call(tabValue[2]),
              ),
            ),
            Expanded(
              child: itemBottomBar(
                valueTab: tabValue[3],
                iconData: Icons.menu,
                title: 'Menu',
                onChangeTab: () => widget.onChangeTab.call(tabValue[3]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBottomBar({
    required int valueTab,
    required IconData iconData,
    required String title,
    required Function onChangeTab,
  }) {
    return RadioCustomComp<int>(
      value: valueTab,
      scaleBegin: 1,
      scaleEnd: 1.2,
      onChanged: (_) {
        setState(() {
          tabIndex = valueTab;
          onChangeTab.call();
        });
      },
      groupValue: tabIndex,
      widgetDefault: Icon(
        iconData,
        color: Colors.grey.withOpacity(0.5),
      ),
      widgetSelected: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(
            height: 6,
          )
        ],
      ),
    );
  }
}
