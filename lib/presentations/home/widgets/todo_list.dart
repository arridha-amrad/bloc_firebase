import 'package:bloc_firebase/presentations/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) => Text(state.todos[index].title),
      ),
    );
  }
}
