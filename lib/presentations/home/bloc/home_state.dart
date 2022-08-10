part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Todo> todos;
  const HomeState({this.todos = const <Todo>[]});

  HomeState copyWith({
    List<Todo>? todos,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos];
}

// class TodoLoading extends HomeState {
//   const TodoLoading();
// }

// class TodoLoaded extends HomeState {
//   final List<Todo> todos;
//   const TodoLoaded({this.todos = const <Todo>[]});
//   @override
//   List<Object> get props => [todos];
// }
