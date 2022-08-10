import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoInputDescription extends StatelessWidget {
  const TodoInputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          onChanged: (val) =>
              context.read<TodoBloc>().add(TodoEventDescriptionChanged(val)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Decsription",
          ),
        );
      },
    );
  }
}
