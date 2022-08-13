part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TodosLoaded extends HomeEvent {}

class SetTodos extends HomeEvent {
  final List<Todo> todos;
  const SetTodos(this.todos);
  @override
  List<Object> get props => [todos];
}

class Logout extends HomeEvent {}
