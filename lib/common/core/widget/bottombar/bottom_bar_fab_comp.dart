import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';

import 'painter_bottombar.dart';

class BottomBarFabComp extends StatefulWidget {
  const BottomBarFabComp({Key? key}) : super(key: key);

  @override
  State<BottomBarFabComp> createState() => _BottomBarFabCompState();
}

class _BottomBarFabCompState extends State<BottomBarFabComp> {
  bool item1 = true;
  bool item2 = false;
  bool item3 = false;
  bool item4 = false;
  late bool indexItem;

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
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
          },
          child: Icon(Icons.send), //icon inside button
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 56,
        child: BottomAppBar(
          //bottom navigation bar on scaffold
          color: Colors.redAccent,
          shape: const CircularBottomBar(
              leftCornerRadius: 16, rightCornerRadius: 16),
          notchMargin: 10,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[


              RadioCustomComp<bool>(
                  value: item1,
                  scaleEnd: 1.5,
                  onChanged: (bool? value) {
                    setState(() {
                      indexItem = item1;
                    });
                  },
                  groupValue: indexItem,
                  widgetDefault: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  widgetSelected: Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
              RadioCustomComp<bool>(
                  value: item2,
                  scaleEnd: 1.5,
                  onChanged: (bool? value) {
                    setState(() {
                      indexItem = item2;
                    });
                  },
                  groupValue: indexItem,
                  widgetDefault: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  widgetSelected: Icon(
                    Icons.home,
                    color: Colors.black,
                  )),
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
