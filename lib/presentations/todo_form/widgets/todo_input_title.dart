import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todo_form/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoInputTitle extends StatelessWidget {
  const TodoInputTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return TextFormField(
          initialValue: todo?.title,
          onChanged: (value) =>
              context.read<TodoBloc>().add(TitleChanged(value)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Title",
          ),
        );
      },
    );
  }
}
