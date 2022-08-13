import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todo_form/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoInputDescription extends StatelessWidget {
  const TodoInputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          maxLines: 5,
          initialValue: todo?.description,
          onChanged: (val) =>
              context.read<TodoBloc>().add(DescriptionChanged(val)),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Description",
          ),
        );
      },
    );
  }
}
