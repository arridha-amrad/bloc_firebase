import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:formz/formz.dart';

class TodoInputDue extends StatefulWidget {
  const TodoInputDue({Key? key}) : super(key: key);

  @override
  State<TodoInputDue> createState() => _TodoInputDueState();
}

class _TodoInputDueState extends State<TodoInputDue> {
  TextEditingController dueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          dueController.clear();
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        buildWhen: (previous, current) => previous.due != current.due,
        builder: (context, state) {
          return TextFormField(
            onTap: () => _pickDueTime(context),
            controller: dueController,
            readOnly: true,
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
                labelText: "Due time"),
          );
        },
      ),
    );
  }

  _pickDueTime(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    ).then((date) => date == null
        ? null
        : showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((time) {
            if (time == null) {
              return null;
            }
            final timeInMilliSeconds = date.millisecondsSinceEpoch +
                (time.hour * 3600 * 1000 + time.minute * 60 * 1000);
            final formattedDate = DateFormat.yMMMd().format(
                DateTime.fromMillisecondsSinceEpoch(timeInMilliSeconds));
            final formattedTime = DateFormat.jm().format(
                DateTime.fromMillisecondsSinceEpoch(timeInMilliSeconds));
            dueController.text = "$formattedTime / $formattedDate";
            context
                .read<TodoBloc>()
                .add(TodoEventDueChanged(timeInMilliSeconds));
          }));
  }
}
