import 'package:bloc_firebase/domain/domain.dart';

import 'package:bloc_firebase/presentations/todo_form/bloc/todo_bloc.dart';
import 'package:bloc_firebase/presentations/todo_form/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../shared/shared.dart';

class TodoFormView extends StatelessWidget {
  const TodoFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;
    return BlocProvider(
      create: (context) => TodoBloc(
        authenticationRepository: AuthenticationRepositoryImpl(),
        todoRepository: TodoRepositoryImpl(),
      )..add(SelectTodo(todo)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(todo == null ? "Create Todo" : "Update Todo"),
        ),
        body: BlocListener<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state.status.isSubmissionFailure) {
                SnackBarUtil.set(state.message, context, Colors.red);
              }
              if (state.status.isSubmissionSuccess) {
                SnackBarUtil.set(state.message, context, Colors.green);
                Navigator.of(context).pop();
              }
            },
            child: Stack(
              children: [
                SizedBox(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      const SizedBox(height: 12),
                      todo == null
                          ? const SizedBox.shrink()
                          : const CheckBoxIsDone(),
                      const TodoInputDue(),
                      const SizedBox(height: 12),
                      const TodoInputTitle(),
                      const SizedBox(height: 12),
                      const TodoInputDescription(),
                      const SizedBox(height: 12),
                      const TodoAddButton(),
                      const SizedBox(height: 12),
                      todo == null
                          ? const SizedBox.shrink()
                          : const TodoDeleteButton(),
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
