import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/presentations/home/data/menu_items.dart';
import 'package:bloc_firebase/presentations/home/models/item.dart';
import 'package:bloc_firebase/presentations/home/widgets/todo_list.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        authenticationRepository: AuthenticationRepositoryImpl(),
        todoRepository: TodoRepositoryImpl(),
      )..add(TodosLoaded()),
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous.todos != current.todos,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home View"),
              centerTitle: true,
              actions: [
                PopupMenuButton<Item>(
                  onSelected: (item) => _select(context, item),
                  itemBuilder: (context) {
                    return [
                      ...MenuItems.listOne
                          .map((item) => _buildItem(context, item))
                          .toList(),
                      const PopupMenuDivider(),
                      ...MenuItems.listTwo
                          .map((item) => _buildItem(context, item))
                          .toList(),
                    ];
                  },
                )
              ],
            ),
            body: const TodoList(),
          );
        },
      ),
    );
  }

  void _select(BuildContext context, Item item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.of(context).pushNamed(Routes.settings.name);
        break;
      case MenuItems.createTodo:
        Navigator.of(context).pushNamed(Routes.todoForm.name);
        break;
      case MenuItems.signOut:
        _logout(context);
        break;
    }
  }

  _logout(BuildContext context) {
    context.read<HomeBloc>().add(Logout());
    Navigator.of(context).pushReplacementNamed(Routes.login.name);
  }

  PopupMenuItem<Item> _buildItem(BuildContext context, Item item) {
    return PopupMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(
              item.icon,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            const SizedBox(width: 12),
            Text(item.text),
          ],
        ));
  }
}
