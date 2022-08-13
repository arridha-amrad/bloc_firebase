part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class DeleteTodo extends TodoEvent {
  const DeleteTodo();
}

class LoadTodos extends TodoEvent {}

class ChangeIsDone extends TodoEvent {
  final bool isDone;
  const ChangeIsDone(this.isDone);
  @override
  List<Object> get props => [isDone];
}

class SetTodos extends TodoEvent {
  final List<Todo> todos;
  const SetTodos(this.todos);
  @override
  List<Object> get props => [todos];
}

class SelectTodo extends TodoEvent {
  final Todo? todo;
  const SelectTodo(this.todo);
  @override
  List<Object?> get props => [todo];
}

class TitleChanged extends TodoEvent {
  final String title;
  const TitleChanged(this.title);
  @override
  List<Object> get props => [title];
}

class DescriptionChanged extends TodoEvent {
  final String description;
  const DescriptionChanged(this.description);
  @override
  List<Object> get props => [description];
}

class DueChanged extends TodoEvent {
  final int due;
  const DueChanged(this.due);
  @override
  List<Object> get props => [due];
}

class AddTodo extends TodoEvent {
  const AddTodo();
}

class UpdateTodo extends TodoEvent {}
