import 'package:bloc_firebase/presentations/todo_form/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxIsDone extends StatelessWidget {
  const CheckBoxIsDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Is Complete"),
            Switch(
              value: state.isDone.value,
              onChanged: (val) {
                context.read<TodoBloc>().add(ChangeIsDone(val));
              },
            )
          ],
        );
      },
    );
  }
}
