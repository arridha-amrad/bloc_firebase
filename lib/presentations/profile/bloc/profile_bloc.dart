import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:bloc_firebase/exceptions/user_exception.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  ProfileBloc(
      {required UserRepository userRepository,
      required AuthenticationRepository authenticationRepository})
      : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const ProfileState()) {
    on<SetUser>(_onSetUser);
  }

  Future<void> _onSetUser(SetUser event, Emitter<ProfileState> emit) async {
    final authUser = _authenticationRepository.getAuthUser();
    if (authUser == null) {
      throw const AuthException(message: "UnAuthenticated");
    }
    try {
      final user = await _userRepository.show(authUser.uid);
      emit(state.copyWith(
        user: user,
        isLoading: false,
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(message: e.message));
    } on UserException catch (e) {
      emit(state.copyWith(message: e.message));
    } catch (e) {
      rethrow;
    }
  }
}
