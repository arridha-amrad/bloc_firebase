import 'package:bloc_firebase/presentations/home/widgets/todo_list.dart';
import 'package:bloc_firebase/repository/todo_repository_impl.dart';
import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        TodoRepositoryImpl(),
      )..add(TodosLoaded()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home View"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.todoForm.name);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: const TodoList(),
      ),
    );
  }
}
