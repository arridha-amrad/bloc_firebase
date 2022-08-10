import 'package:bloc_firebase/presentations/todos/todo_view.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
import 'package:bloc_firebase/repository/todo_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';
import 'widgets/todo_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("HomeView"),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.chevron_right),
          onPressed: () => Navigator.of(context).push(TodoView.route()),
        ),
        body: BlocProvider<HomeBloc>(
          create: (_) =>
              HomeBloc(AuthenticationRepositoryImpl(), TodoRepositoryImpl())
                ..add(
                  LoadTodos(),
                ),
          child: const TodoList(),
        ));
  }
}
