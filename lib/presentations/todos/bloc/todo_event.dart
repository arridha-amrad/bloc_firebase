part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoEventLoadTodos extends TodoEvent {
  const TodoEventLoadTodos();
}

class TodoEventChangeIsDone extends TodoEvent {
  final bool isDone;
  const TodoEventChangeIsDone(this.isDone);
  @override
  List<Object> get props => [isDone];
}

class TodoEventSetTodos extends TodoEvent {
  final List<Todo> todos;
  const TodoEventSetTodos(this.todos);
  @override
  List<Object> get props => [todos];
}

class TodoEventSelectTodo extends TodoEvent {
  final Todo todo;
  const TodoEventSelectTodo(this.todo);
  @override
  List<Object> get props => [todo];
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

class TodoEventUpdateTodo extends TodoEvent {
  const TodoEventUpdateTodo();
}
