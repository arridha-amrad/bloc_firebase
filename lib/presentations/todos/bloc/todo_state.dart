part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final Title title;
  final Description description;
  final FormzStatus status;
  final Alert alert;
  final Due due;

  const TodoState({
    this.title = const Title.pure(),
    this.description = const Description.pure(),
    this.status = FormzStatus.pure,
    this.alert = const Alert.empty(),
    this.due = const Due.pure(),
  });

  TodoState copyWith({
    Title? title,
    Description? description,
    FormzStatus? status,
    Alert? alert,
    Due? due,
  }) {
    return TodoState(
      description: description ?? this.description,
      title: title ?? this.title,
      status: status ?? this.status,
      alert: alert ?? this.alert,
      due: due ?? this.due,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        status,
        alert,
        due,
      ];
}
