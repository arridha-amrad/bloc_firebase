import 'package:bloc_firebase/presentations/home/widgets/todo_list.dart';
import 'package:bloc_firebase/presentations/todos/todo_view.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
import 'package:bloc_firebase/repository/todo_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../todos/bloc/todo_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
        todoRepository: TodoRepositoryImpl(),
        authenticationRepository: AuthenticationRepositoryImpl(),
      )..add(const TodoEventLoadTodos()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("HomeView"),
        ),
        floatingActionButton: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            return FloatingActionButton(
              child: const Icon(Icons.chevron_right),
              onPressed: () =>
                  Navigator.of(context).push(TodoView.route(context: context)),
            );
          },
        ),
        body: const TodoList(),
      ),
    );
  }
}
