import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoInputDue extends StatelessWidget {
  const TodoInputDue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) => previous.due != current.due,
      builder: (context, state) {
        return TextFormField(
          onTap: () => _pickDueTime(context),
          onChanged: (val) =>
              context.read<TodoBloc>().add(TodoEventDueChanged(int.parse(val))),
          readOnly: true,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.calendar_month),
              border: OutlineInputBorder(),
              labelText: "Due time"),
        );
      },
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
            final dateMilliSeconds = date.millisecondsSinceEpoch;
            final timeOfDayMilliSeconds =
                time.hour * 3600 * 1000 + time.minute * 60 * 1000;
            context.read<TodoBloc>().add(
                TodoEventDueChanged(dateMilliSeconds + timeOfDayMilliSeconds));
          }));
  }
}
