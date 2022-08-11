import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:bloc_firebase/presentations/todos/todo_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) =>
          previous.todos.length != current.todos.length,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            final due =
                "${DateFormat.jm().format(todo.createdAt)} - ${DateFormat.yMMMEd().format(todo.createdAt)}";
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[50]),
              child: ListTile(
                onTap: () {
                  context.read<TodoBloc>().add(TodoEventSelectTodo(todo));
                  Navigator.of(context).push(TodoView.route(
                    todo: todo,
                    context: context,
                  ));
                },
                trailing: Text(
                  todo.isDone ? "Complete" : "Waiting",
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                title: Text(
                  todo.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      due,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
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
