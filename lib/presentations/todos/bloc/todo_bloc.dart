import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/todo_repository.dart';
import 'package:bloc_firebase/exceptions/todo_exception.dart';
import 'package:bloc_firebase/models/alert.dart';
import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todos/models_validator/description.dart';
import 'package:bloc_firebase/presentations/todos/models_validator/title.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  TodoBloc(TodoRepository todoRepository)
      : _todoRepository = todoRepository,
        super(const TodoState()) {
    on<TodoEventTitleChanged>(_onTitleChanged);
    on<TodoEventDueChanged>(_onDueChanged);
    on<TodoEventDescriptionChanged>(_onDescriptionChanged);
    on<TodoEventAddNewTodo>(_onAddTodo);
  }

  void _onDueChanged(TodoEventDueChanged event, Emitter<TodoState> emit) {
    final due = event.due;
    emit(state.copyWith(due: due));
  }

  void _onTitleChanged(TodoEventTitleChanged event, Emitter<TodoState> emit) {
    final title = Title.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.description]),
    ));
  }

  void _onDescriptionChanged(
      TodoEventDescriptionChanged event, Emitter<TodoState> emit) {
    final description = Description.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([description, state.description]),
    ));
  }

  Future<void> _onAddTodo(
      TodoEventAddNewTodo event, Emitter<TodoState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final dateNow = DateTime.now();
        final todo = Todo(
          createdAt: dateNow,
          updatedAt: dateNow,
          description: state.description.value,
          title: state.title.value,
          id: const Uuid().v4(),
          isDone: false,
          due: state.due,
        );
        await _todoRepository.save(todo);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on TodoException catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          alert: Alert(message: e.message, type: AlertType.error),
        ));
      } catch (e) {
        rethrow;
      }
    }
  }
}
