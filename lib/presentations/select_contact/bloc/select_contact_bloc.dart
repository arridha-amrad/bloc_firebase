import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:equatable/equatable.dart';

part 'select_contact_event.dart';
part 'select_contact_state.dart';

class SelectContactBloc extends Bloc<SelectContactEvent, SelectContactState> {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  SelectContactBloc({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const SelectContactState()) {
    on<SetUsers>(_onSetUsers);
    on<LoadUsers>(_onLoadUsers);
    on<SearchChanged>(_onSearchChanged);
    on<ToggleSearch>(_onSearchToggled);
  }

  Future<void> _onSearchChanged(
      SearchChanged event, Emitter<SelectContactState> emit) async {
    final key = event.text;
    final authUser = _authenticationRepository.getAuthUser();

    await emit.forEach(
      _userRepository.search(key),
      onData: (List<UserStore> data) {
        final result = data.where((user) => user.id != authUser!.uid).toList();
        return state.copyWith(users: result);
      },
    );
  }

  void _onSearchToggled(ToggleSearch event, Emitter<SelectContactState> emit) {
    emit(state.copyWith(isSearch: !state.isSearch));
  }

  void _onSetUsers(SetUsers event, Emitter<SelectContactState> emit) {
    final authUser = _authenticationRepository.getAuthUser();
    if (authUser == null) {
      throw const AuthException(message: "UnAuthenticated");
    }
    final users = event.users;
    final filteredUser =
        users.where((user) => user.id != authUser.uid).toList();
    emit(state.copyWith(
      users: filteredUser,
      isLoading: false,
    ));
  }

  Future<void> _onLoadUsers(
      LoadUsers event, Emitter<SelectContactState> emit) async {
    final authUser = _authenticationRepository.getAuthUser();
    if (authUser == null) {
      throw const AuthException(message: "UnAuthenticated");
    }
    try {
      await emit.forEach(
        _userRepository.showAll(),
        onData: (List<UserStore> data) {
          final users = data.where((user) => user.id != authUser.uid).toList();
          return state.copyWith(isLoading: false, users: users);
        },
      );
    } on AuthException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (e) {
      rethrow;
    }
  }
}
