import 'package:bloc_firebase/presentations/todos/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        create: (context) => TodoBloc(),
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Title"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: const Text("Create"))
          ],
        ),
      ),
    );
  }
}
