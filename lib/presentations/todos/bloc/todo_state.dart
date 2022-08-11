part of 'todo_bloc.dart';

class TodoState extends Equatable {
  @override
  List<Object> get props =>
      [title, description, status, alert, due, todos, isFetching, isDone];

  final Title title;
  final Description description;
  final FormzStatus status;
  final Alert alert;
  final Due due;
  final List<Todo> todos;
  final bool isFetching;
  final bool isDone;

  const TodoState({
    this.title = const Title.pure(),
    this.description = const Description.pure(),
    this.status = FormzStatus.pure,
    this.alert = const Alert.empty(),
    this.due = const Due.pure(),
    this.todos = const <Todo>[],
    this.isFetching = false,
    this.isDone = false,
  });

  TodoState copyWith({
    Title? title,
    Description? description,
    FormzStatus? status,
    Alert? alert,
    Due? due,
    List<Todo>? todos,
    bool? isFetching,
    bool? isDone,
  }) {
    return TodoState(
      description: description ?? this.description,
      title: title ?? this.title,
      status: status ?? this.status,
      alert: alert ?? this.alert,
      due: due ?? this.due,
      todos: todos ?? this.todos,
      isFetching: isFetching ?? this.isFetching,
      isDone: isDone ?? this.isDone,
    );
  }
}
