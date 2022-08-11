import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoInputTitle extends StatelessWidget {
  const TodoInputTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.title.value,
          onChanged: (value) =>
              context.read<TodoBloc>().add(TodoEventTitleChanged(value)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Title",
          ),
        );
      },
    );
  }
}
