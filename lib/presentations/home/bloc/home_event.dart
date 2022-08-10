part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Logout extends HomeEvent {
  const Logout();
}

class LoadTodos extends HomeEvent {}

class UpdateTodos extends HomeEvent {
  final List<Todo> todos;
  const UpdateTodos(this.todos);
  @override
  List<Object> get props => [todos];
}

class EventToState extends HomeEvent {
  const EventToState();
}
