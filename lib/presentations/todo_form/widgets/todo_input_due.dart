import 'package:bloc_firebase/domain/models/todo.dart';
import 'package:bloc_firebase/presentations/todo_form/bloc/todo_bloc.dart';
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
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          dueController.clear();
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        buildWhen: (previous, current) => previous.due != current.due,
        builder: (context, state) {
          if (todo != null) {
            final formattedDate = _dateFormatter(todo.due);
            final formattedTime = _timeFormatter(todo.due);
            dueController.text = "$formattedTime / $formattedDate";
          }
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

  _dateFormatter(int milliseconds) {
    return DateFormat.yMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
  }

  _timeFormatter(int milliseconds) {
    return DateFormat.jm()
        .format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
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
            final formattedDate = _dateFormatter(timeInMilliSeconds);
            final formattedTime = _timeFormatter(timeInMilliSeconds);
            dueController.text = "$formattedTime / $formattedDate";
            context.read<TodoBloc>().add(DueChanged(timeInMilliSeconds));
          }));
  }
}
