part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoEventTitleChanged extends TodoEvent {
  final String title;
  const TodoEventTitleChanged(this.title);
  @override
  List<Object> get props => [title];
}

class TodoEventDescriptionChanged extends TodoEvent {
  final String description;
  const TodoEventDescriptionChanged(this.description);
  @override
  List<Object> get props => [description];
}

class TodoEventDueChanged extends TodoEvent {
  final int due;
  const TodoEventDueChanged(this.due);
  @override
  List<Object> get props => [due];
}

class TodoEventAddNewTodo extends TodoEvent {
  const TodoEventAddNewTodo();
}
