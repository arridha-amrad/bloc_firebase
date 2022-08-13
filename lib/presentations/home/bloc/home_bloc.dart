import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/todo_repository.dart';
import 'package:bloc_firebase/models/todo.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository _todoRepository;
  HomeBloc(TodoRepository todoRepository)
      : _todoRepository = todoRepository,
        super(const HomeState()) {
    on<TodosLoaded>(_onTodosLoaded);
  }

  Future<void> _onTodosLoaded(
      TodosLoaded event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    await emit.forEach<List<Todo>>(_todoRepository.getAllTodos(),
        onData: (todos) => state.copyWith(
              todos: todos,
              isLoading: false,
            ));
  }
}
