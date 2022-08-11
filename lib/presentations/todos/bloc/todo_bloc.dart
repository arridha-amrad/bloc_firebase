import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/abstracts/todo_repository.dart';
import 'package:bloc_firebase/exceptions/todo_exception.dart';
import 'package:bloc_firebase/models/alert.dart';
import 'package:bloc_firebase/models/todo.dart';
import 'package:bloc_firebase/presentations/todos/models_validator/description.dart';
import 'package:bloc_firebase/presentations/todos/models_validator/due.dart';
import 'package:bloc_firebase/presentations/todos/models_validator/title.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  final AuthenticationRepository _authenticationRepository;

  TodoBloc({
    required TodoRepository todoRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _todoRepository = todoRepository,
        _authenticationRepository = authenticationRepository,
        super(const TodoState()) {
    on<TodoEventTitleChanged>(_onTitleChanged);
    on<TodoEventDueChanged>(_onDueChanged);
    on<TodoEventDescriptionChanged>(_onDescriptionChanged);
    on<TodoEventAddNewTodo>(_onAddTodo);
    on<TodoEventLoadTodos>(_onLoadTodos);
    on<TodoEventChangeIsDone>(_onChangeIsDone);
    on<TodoEventSetTodos>(_onSetTodos);
    on<TodoEventSelectTodo>(_onSelectTodo);
    on<TodoEventUpdateTodo>(_onUpdateTodo);
  }

  Future<void> _onUpdateTodo(
      TodoEventUpdateTodo event, Emitter<TodoState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {} catch (e) {
        rethrow;
      }
    }
  }

  void _onChangeIsDone(TodoEventChangeIsDone event, Emitter<TodoState> emit) {
    emit(state.copyWith(isDone: event.isDone));
  }

  void _onLoadTodos(TodoEventLoadTodos event, Emitter<TodoState> emit) {
    emit(state.copyWith(isFetching: true));
    _todoRepository
        .getAllTodos()
        .listen((todos) => add(TodoEventSetTodos(todos)));
  }

  void _onSetTodos(TodoEventSetTodos event, Emitter<TodoState> emit) {
    emit(state.copyWith(todos: event.todos, isFetching: false));
  }

  void _onSelectTodo(TodoEventSelectTodo event, Emitter<TodoState> emit) {
    final Todo todo = event.todo;
    emit(state.copyWith(
      title: Title.dirty(todo.title),
      description: Description.dirty(todo.description),
      isDone: todo.isDone,
      due: Due.dirty(todo.due),
      status: FormzStatus.valid,
    ));
  }

  void _onDueChanged(TodoEventDueChanged event, Emitter<TodoState> emit) {
    final due = Due.dirty(event.due);
    emit(state.copyWith(
        due: due,
        status: Formz.validate([due, state.title, state.description])));
  }

  void _onTitleChanged(TodoEventTitleChanged event, Emitter<TodoState> emit) {
    final title = Title.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.description, state.due]),
    ));
  }

  void _onDescriptionChanged(
      TodoEventDescriptionChanged event, Emitter<TodoState> emit) {
    final description = Description.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([description, state.description, state.due]),
    ));
  }

  Future<void> _onAddTodo(
      TodoEventAddNewTodo event, Emitter<TodoState> emit) async {
    if (_authenticationRepository.getAuthUser() == null) return;
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final dateNow = DateTime.now();
        final todo = Todo(
          userId: _authenticationRepository.getAuthUser()!.uid,
          description: state.description.value,
          title: state.title.value,
          due: state.due.value,
          id: const Uuid().v4(),
          isDone: false,
          createdAt: dateNow,
          updatedAt: dateNow,
        );
        await _todoRepository.save(todo);
        emit(state.copyWith(
            status: FormzStatus.submissionSuccess,
            alert: const Alert(
                message: "New todo created successfully",
                type: AlertType.success)));
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
