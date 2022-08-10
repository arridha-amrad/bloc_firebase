import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoAddButton extends StatelessWidget {
  const TodoAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
            onPressed: state.status.isValidated
                ? () =>
                    context.read<TodoBloc>().add(const TodoEventAddNewTodo())
                : null,
            child: const Text("Submit"));
      },
    );
  }
}
