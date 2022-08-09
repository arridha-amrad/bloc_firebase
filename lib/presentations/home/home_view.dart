import 'package:bloc_firebase/presentations/todos/todo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("HomeView"),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(const Logout());
                  },
                  icon: const Icon(Icons.logout))
            ],
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(TodoView.route()),
              child: const Text("Todo"),
            ),
          ),
        );
      },
    );
  }
}
