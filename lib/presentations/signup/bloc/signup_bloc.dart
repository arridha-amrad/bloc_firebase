import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/domain/domain.dart';

import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:bloc_firebase/presentations/shared/shared.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  SignupBloc(AuthenticationRepository authenticationRepository,
      UserRepository userRepository)
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const SignupState()) {
    on<EmailChanged>(_onEmailChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSubmit);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<SignupState> emit) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([username, state.email, state.password]),
    ));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.username, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.username, state.email]),
    ));
  }

  Future<void> _onSubmit(
      SignUpSubmitted event, Emitter<SignupState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final UserCredential userCredential = await _authenticationRepository
            .signup(state.email.value, state.password.value);
        final user = userCredential.user;
        if (user == null) {
          throw const AuthException(message: "Failed get the user");
        }
        await _userRepository.save(
          UserStore(
            user.uid,
            state.username.value,
            user.email!,
            DateTime.now(),
            DateTime.now(),
            "https://firebasestorage.googleapis.com/v0/b/learn-flutter-firebase-081215.appspot.com/o/avatar%2Fdefault-profile-icon-24.jpg?alt=media&token=b8609a7d-ab82-43e2-8dc6-a460b715e30b",
          ),
        );
        await _authenticationRepository.sendEmailVerification();
        await _authenticationRepository.logout();
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on AuthException catch (e) {
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
