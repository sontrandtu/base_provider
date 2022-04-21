import 'package:achitech_weup/common/core/app_core.dart';
import 'package:achitech_weup/common/core/widget/text_field_comp.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var ted1 = TextEditingController();
  var ted2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropKeyboard(
      child: Column(
        children: [
          TextFieldComp(
            hint: 'Test1',
            editingController: ted1,
            isUnderLine: true,
            isBorder:true,
          ),
          TextButtonComp(title: 'ABC', onPressed: () {}),
          IconButton(onPressed: (){}, icon: Icon(Icons.add),splashRadius: 1,),
          InkWellComp(onTap: (){}, child: Icon(Icons.add)),
          DropdownComp(
            listItems: [
              BaseOptionDropdown(id: '1', name: '1adfgdfsgdasfdasfdsfdasfsdfasfdasfsfdsfdsfdasfdsfdsfdsfdsffaadsfdsfdsfdsfsdfasdfdasfdssdfdasf'),
              BaseOptionDropdown(id: '2', name: '2adfgdfsgdasfdasfdsfdasfsdfasfdasfsfdsfdsfdasfdsfdsfdsfdsffaadsfdsfdsfdsfsdfasdfdasfdssdfdasf'),
              BaseOptionDropdown(id: '3', name: '3adfgdfsgdasfdasfdsfdasfsdfasfdasfsfdsfdsfdasfdsfdsfdsfdsffaadsfdsfdsfdsfsdfasdfdasfdssdfdasf')
            ],
            isBorder: true,
            label: 'Chọn',
            onTapCallBack:(value, index){
              print('${value.name} $index');
            } ,
          )
        ],
      ),
    );
  }
}
