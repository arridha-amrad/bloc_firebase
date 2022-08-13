part of 'home_bloc.dart';

class HomeState extends Equatable {
  @override
  List<Object> get props => [todos, isLoading];

  final List<Todo> todos;
  final bool isLoading;

  const HomeState({
    this.todos = const <Todo>[],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<Todo>? todos,
    bool? isLoading,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
