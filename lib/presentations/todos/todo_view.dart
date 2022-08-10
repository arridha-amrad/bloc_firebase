import 'package:bloc_firebase/presentations/shared/snackbar_util.dart';
import 'package:bloc_firebase/presentations/shared/widgets/off_screen_loading.dart';
import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_add_button.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_input_description.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_input_due.dart';
import 'package:bloc_firebase/presentations/todos/widgets/todo_input_title.dart';
import 'package:bloc_firebase/repository/auth_repo_impl.dart';
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
        create: (context) =>
            TodoBloc(TodoRepositoryImpl(), AuthenticationRepositoryImpl()),
        child: BlocListener<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state.status.isSubmissionFailure) {
                SnackBarUtil.set(state.alert.message, context, Colors.red);
              }
              if (state.status.isSubmissionSuccess) {
                SnackBarUtil.set(state.alert.message, context, Colors.green);
                Navigator.of(context).pop();
              }
            },
            child: Stack(
              children: [
                SizedBox(
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
                const _LoadingIndicator()
              ],
            )),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const OffScreenLoading();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
