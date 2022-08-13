import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository _todoRepository;
  final AuthenticationRepository _authenticationRepository;
  HomeBloc(
      {required TodoRepository todoRepository,
      required AuthenticationRepository authenticationRepository})
      : _todoRepository = todoRepository,
        _authenticationRepository = authenticationRepository,
        super(const HomeState()) {
    on<TodosLoaded>(_onTodosLoaded);
    on<SetTodos>(_onSetTodos);
    on<Logout>(_onLogout);
  }

  Future<void> _onLogout(Logout event, Emitter<HomeState> emit) async {
    await _authenticationRepository.logout();
  }

  void _onSetTodos(SetTodos event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      todos: event.todos,
      isLoading: false,
    ));
  }

  Future<void> _onTodosLoaded(
      TodosLoaded event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    _todoRepository.getAllTodos().listen((todos) => add(SetTodos(todos)));
    // await emit.forEach<List<Todo>>(_todoRepository.getAllTodos(),
    //     onData: (todos) => state.copyWith(todos: todos, isLoading: false));
  }
}
