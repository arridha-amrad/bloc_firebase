// import 'package:bloc_firebase/models/todo.dart';
// import 'package:bloc_firebase/presentations/shared/snackbar_util.dart';
// import 'package:bloc_firebase/presentations/shared/widgets/off_screen_loading.dart';
// import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
// import 'package:bloc_firebase/presentations/todos/widgets/check_box_is_done.dart';
// import 'package:bloc_firebase/presentations/todos/widgets/todo_add_button.dart';
// import 'package:bloc_firebase/presentations/todos/widgets/todo_input_description.dart';
// import 'package:bloc_firebase/presentations/todos/widgets/todo_input_due.dart';
// import 'package:bloc_firebase/presentations/todos/widgets/todo_input_title.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';

// class TodoDetailView extends StatelessWidget {
//   const TodoDetailView({Key? key}) : super(key: key);

//   static Route<void> route(BuildContext context, Todo todo) {
//     return MaterialPageRoute<void>(
//         builder: (_) => BlocProvider.value(
//               value: BlocProvider.of<TodoBloc>(context)
//                 ..add(TodoEventSelectTodo(todo)),
//               child: const TodoDetailView(),
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Todo Detail View"),
//       ),
//       body: BlocListener<TodoBloc, TodoState>(
//           listener: (context, state) {
//             if (state.status.isSubmissionFailure) {
//               SnackBarUtil.set(state.alert.message, context, Colors.red);
//             }
//             if (state.status.isSubmissionSuccess) {
//               SnackBarUtil.set(state.alert.message, context, Colors.green);
//               Navigator.of(context).pop();
//             }
//           },
//           child: Stack(
//             children: [
//               SizedBox(
//                 child: ListView(
//                   padding: const EdgeInsets.all(12),
//                   children: const [
//                     SizedBox(height: 12),
//                     CheckBoxIsDone(),
//                     SizedBox(height: 12),
//                     TodoInputDue(),
//                     SizedBox(height: 12),
//                     TodoInputTitle(),
//                     SizedBox(height: 12),
//                     TodoInputDescription(),
//                     SizedBox(height: 12),
//                     TodoAddButton()
//                   ],
//                 ),
//               ),
//               const _LoadingIndicator()
//             ],
//           )),
//     );
//   }
// }

// class _LoadingIndicator extends StatelessWidget {
//   const _LoadingIndicator({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TodoBloc, TodoState>(
//       builder: (context, state) {
//         if (state.status.isSubmissionInProgress) {
//           return const OffScreenLoading();
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
