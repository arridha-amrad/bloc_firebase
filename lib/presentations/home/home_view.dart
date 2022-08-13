import 'package:bloc_firebase/domain/domain.dart';
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
              leading: IconButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(Logout());
                  },
                  icon: const Icon(Icons.logout)),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.todoForm.name);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: const TodoList(),
          );
        },
      ),
    );
  }
}
