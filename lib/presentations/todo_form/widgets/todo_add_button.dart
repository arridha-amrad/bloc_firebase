import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todo_form/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoAddButton extends StatelessWidget {
  const TodoAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => todo == null
                  ? context.read<TodoBloc>().add(const AddTodo())
                  : context.read<TodoBloc>().add(UpdateTodo())
              : null,
          child: Text(todo == null ? "Submit" : "Update"),
        );
      },
    );
  }
}
