import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/exceptions/todo_exception.dart';
import 'package:bloc_firebase/presentations/todo_form/models_validator/is_done.dart';
import 'package:bloc_firebase/presentations/todo_form/models_validator/model_validator.dart';
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
    on<TitleChanged>(_onTitleChanged);
    on<DueChanged>(_onDueChanged);
    on<DescriptionChanged>(_onDescriptionChanged);
    on<AddTodo>(_onAddTodo);
    on<LoadTodos>(_onLoadTodos);
    on<ChangeIsDone>(_onChangeIsDone);
    on<SetTodos>(_onSetTodos);
    on<SelectTodo>(_onSelectTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    if (state.todo == null) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _todoRepository.delete(state.todo!);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: "Todo deleted successfully"));
    } on TodoException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    if (state.todo == null) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      Todo todo = state.todo!;
      final newTodo = todo.copyWith(
        updatedAt: DateTime.now(),
        isDone: state.isDone.value,
        description: state.description.value,
        title: state.title.value,
      );
      await _todoRepository.update(newTodo);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: "Todo updated successfully"));
    } on TodoException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    } catch (e) {
      rethrow;
    }
  }

  void _onChangeIsDone(ChangeIsDone event, Emitter<TodoState> emit) {
    final isDone = IsDone.dirty(event.isDone);
    emit(state.copyWith(
        isDone: isDone,
        status: Formz.validate([
          isDone,
          state.description,
          state.title,
          state.due,
        ])));
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    await emit.forEach<List<Todo>>(_todoRepository.getAllTodos(),
        onData: (todos) => state.copyWith(todos: todos));
  }

  void _onSetTodos(SetTodos event, Emitter<TodoState> emit) {
    emit(state.copyWith(todos: event.todos, isFetching: false));
  }

  void _onSelectTodo(SelectTodo event, Emitter<TodoState> emit) {
    final todo = event.todo;
    if (todo == null) return;
    emit(state.copyWith(
      todo: todo,
      description: Description.dirty(todo.description),
      title: Title.dirty(todo.title),
      due: Due.dirty(todo.due),
      status: Formz.validate([
        state.description,
        state.title,
        state.due,
        state.isDone,
      ]),
      isDone: IsDone.dirty(todo.isDone),
    ));
  }

  void _onDueChanged(DueChanged event, Emitter<TodoState> emit) {
    final due = Due.dirty(event.due);
    emit(state.copyWith(
        due: due,
        status: Formz.validate(
            [due, state.title, state.description, state.isDone])));
  }

  void _onTitleChanged(TitleChanged event, Emitter<TodoState> emit) {
    final title = Title.dirty(event.title);
    emit(state.copyWith(
      title: title,
      status:
          Formz.validate([title, state.description, state.due, state.isDone]),
    ));
  }

  void _onDescriptionChanged(
      DescriptionChanged event, Emitter<TodoState> emit) {
    final description = Description.dirty(event.description);
    emit(state.copyWith(
      description: description,
      status: Formz.validate(
          [description, state.description, state.due, state.isDone]),
    ));
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
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
            message: "New todo created successfully"));
      } on TodoException catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
          message: e.message,
        ));
      } catch (e) {
        rethrow;
      }
    }
  }
}
