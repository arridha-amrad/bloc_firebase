import 'package:bloc_firebase/routes.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/home_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.todos != current.todos,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            final due =
                "${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(todo.due))} - ${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(todo.due))}";
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[50]),
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.todoForm.name, arguments: todo);
                },
                trailing: Text(todo.isDone ? "Complete" : "Waiting",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                title: Text(todo.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(due,
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                    const SizedBox(height: 12),
                    Text(todo.description),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
