part of 'todo_bloc.dart';

class TodoState extends Equatable {
  @override
  List<Object?> get props =>
      [title, description, due, isDone, todos, status, message, todo];

  final Todo? todo;
  final Title title;
  final Description description;
  final FormzStatus status;
  final String message;
  final Due due;
  final List<Todo> todos;
  final IsDone isDone;

  const TodoState({
    this.title = const Title.pure(),
    this.description = const Description.pure(),
    this.status = FormzStatus.pure,
    this.due = const Due.pure(),
    this.todos = const <Todo>[],
    this.isDone = const IsDone.pure(),
    this.message = "",
    this.todo,
  });

  TodoState copyWith({
    Title? title,
    Description? description,
    FormzStatus? status,
    String? message,
    Due? due,
    List<Todo>? todos,
    bool? isFetching,
    IsDone? isDone,
    String? id,
    String? userId,
    Todo? todo,
  }) {
    return TodoState(
      description: description ?? this.description,
      title: title ?? this.title,
      status: status ?? this.status,
      message: message ?? this.message,
      due: due ?? this.due,
      todos: todos ?? this.todos,
      isDone: isDone ?? this.isDone,
      todo: todo ?? this.todo,
    );
  }
}
