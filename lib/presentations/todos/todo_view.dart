import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_add_button.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_input_description.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_input_due.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_input_title.dart';
import 'package:bloc_firebase/repository/todo_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TodoView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo View"),
      ),
      body: BlocProvider(
        create: (context) => TodoBloc(
          TodoRepositoryImpl(),
        ),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.alert.message),
                backgroundColor: Colors.red,
              ));
            }
            if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.alert.message),
                backgroundColor: Colors.green,
              ));
              Navigator.of(context).pop();
            }
          },
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: const [
              SizedBox(height: 12),
              TodoInputDue(),
              SizedBox(height: 12),
              TodoInputTitle(),
              SizedBox(height: 12),
              TodoInputDescription(),
              SizedBox(height: 12),
              TodoAddButton()
            ],
          ),
        ),
      ),
    );
  }
}
