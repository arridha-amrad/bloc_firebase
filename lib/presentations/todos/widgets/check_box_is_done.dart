import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxIsDone extends StatelessWidget {
  final Todo todo;
  const CheckBoxIsDone({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Is Complete"),
            Switch(
              value: state.isDone,
              onChanged: (val) {
                context.read<TodoBloc>().add(TodoEventChangeIsDone(val));
              },
            )
          ],
        );
      },
    );
  }
}
