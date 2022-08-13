import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class TodoDeleteButton extends StatelessWidget {
  const TodoDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => previous.todo != previous.todo,
      builder: (context, state) {
        return ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              // context.read<TodoBloc>().add(const DeleteTodo());
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<TodoBloc>(),
                  child: _showDeleteDialog(context),
                ),
              );
            },
            child: const Text('Delete'));
      },
    );
  }

  _showDeleteDialog(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            style: ButtonStyle(overlayColor: MaterialStateProperty.resolveWith(
              (states) {
                return states.contains(MaterialState.pressed)
                    ? Colors.grey[100]
                    : null;
              },
            )),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.grey),
            )),
        TextButton(
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(const DeleteTodo());
              Navigator.of(context).pop();
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            )),
      ],
      title: const Text("Delete Todo"),
      content: const Text("Are you sure to delete this todo ?"),
    );
  }
}
