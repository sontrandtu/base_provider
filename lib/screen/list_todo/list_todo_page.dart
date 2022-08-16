import 'package:achitecture_weup/common/core/app_core.dart';
import '../../common/core/state/base_state.dart';

import 'package:achitecture_weup/screen/home/components/item_todo.dart';
import 'package:achitecture_weup/screen/list_todo/list_todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTodoPage extends StatefulWidget {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  State<ListTodoPage> createState() => _ListTodoPage();
}

class _ListTodoPage extends BaseState<ListTodoPage, ListTodoViewModel> {
  @override
  ListTodoViewModel get init => ListTodoViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      builder: (_, __) => MainLayout<ListTodoViewModel>(
        appBar: AppBarComp(title: 'List TODO'),
        child: Column(
          children: [
            Row(
              children: [
                TextButtonComp(
                  title: 'Insert',
                  onPressed: viewModel.insert,
                ),
                TextButtonComp(
                  title: 'Remove',
                  onPressed: viewModel.remove,
                ),
              ],
            ),
            Expanded(
              child: Consumer<ListTodoViewModel>(
                builder: (context, value, child) => AnimatedList(
                    key: viewModel.keyList,
                    itemBuilder: _buildItem,
                    initialItemCount: value.animatedList.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return TextButtonComp(
        onPressed: () => viewModel.appNavigator.pushNamed(RoutePath.TODO_LIST),
        child: ItemTodo(s: viewModel.animatedList[index], animation: animation));
  }
}
