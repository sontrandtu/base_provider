import 'dart:developer';

import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

import 'painter_bottombar.dart';

class BottomBarFabComp extends StatefulWidget {
  const BottomBarFabComp({Key? key}) : super(key: key);

  @override
  State<BottomBarFabComp> createState() => _BottomBarFabCompState();
}

class _BottomBarFabCompState extends State<BottomBarFabComp> {
  int item1 = 1;
  int item2 = 2;
  int item3 = 3;
  int item4 = 4;
  late int indexItem;

  @override
  void initState() {
    indexItem = item1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
      ),
      floatingActionButton: ScaleAniButtonComp(
        isElevation: false,
        onPressed: () {},
        padding: EdgeInsets.zero,
        child: const SizedBox(
          height: 60,
          width: 60,
          child: FloatingActionButton(
            backgroundColor: ColorResource.primarySwatch,
            onPressed: null,
            child: Icon(Icons.add,color: Colors.white,), //icon inside button
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 56,
        child: BottomAppBar(
          color: ColorResource.primarySwatch,
          shape: const CircularBottomBar(
              leftCornerRadius: 16, rightCornerRadius: 16),
          notchMargin: 8,
          child: Row(
            children: <Widget>[
              Expanded(
                child: RadioCustomComp<int>(
                  value: item1,
                  scaleBegin: 1,
                  scaleEnd: 1.2,
                  onChanged: (int? value) {
                    setState(() {
                      indexItem = item1;
                    });
                  },
                  groupValue: indexItem,
                  widgetDefault: Icon(
                    Icons.menu,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  widgetSelected: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      Text(
                        'Menu',
                        style: appStyle.textTheme.bodyText2!
                            .copyWith(color: Colors.white, fontSize: 10),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RadioCustomComp<int>(
                  value: item2,
                  scaleBegin: 1,
                  scaleEnd: 1.2,
                  onChanged: (int? value) {
                    setState(() {
                      indexItem = item2;
                    });
                    log('abc');
                  },
                  groupValue: indexItem,
                  widgetDefault: Icon(
                    Icons.home,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  widgetSelected: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      Text(
                        'Home',
                        style: appStyle.textTheme.bodyText2!
                            .copyWith(color: Colors.white, fontSize: 10),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
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
                        style: appStyle.textTheme.bodyText2!
                            .copyWith(color: Colors.white, fontSize: 10),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RadioCustomComp<int>(
                  value: item3,
                  scaleBegin: 1,
                  scaleEnd: 1.2,
                  onChanged: (int? value) {
                    setState(() {
                      indexItem = item3;
                    });
                  },
                  groupValue: indexItem,
                  widgetDefault: Icon(
                    Icons.calendar_today,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  widgetSelected: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      Text(
                        'Calendar',
                        style: appStyle.textTheme.bodyText2!
                            .copyWith(color: Colors.white, fontSize: 10),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RadioCustomComp<int>(
                  value: item4,
                  scaleBegin: 1,
                  scaleEnd: 1.2,
                  onChanged: (int? value) {
                    setState(() {
                      indexItem = item4;
                    });
                  },
                  groupValue: indexItem,
                  widgetDefault: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  widgetSelected: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'Account',
                        style: appStyle.textTheme.bodyText2!
                            .copyWith(color: Colors.white, fontSize: 10),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class BottomBarFabComp extends StatelessWidget {
//   const BottomBarFabComp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         color: Colors.blue,
//       ),
//       floatingActionButton: SizedBox(
//         height: 60,
//         width: 60,
//         child: FloatingActionButton(
//           //Floating action button on Scaffold
//           onPressed: () {
//             //code to execute on button press
//           },
//           child: Icon(Icons.send), //icon inside button
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: SizedBox(
//         height: 56,
//         child: BottomAppBar(
//           //bottom navigation bar on scaffold
//           color: Colors.redAccent,
//           shape: const CircularBottomBar(
//               leftCornerRadius: 16, rightCornerRadius: 16),
//           notchMargin: 10,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               RadioCustomComp<bool>(
//                   value: true,
//                   onChanged: (bool? value){},
//                   groupValue: groupValue,
//                   widgetDefault: widgetDefault,
//                   widgetSelected: widgetSelected),
//               IconButton(
//                 icon: Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.search,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.print,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.people,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
