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
      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (e) {
      rethrow;
    }
  }
}
