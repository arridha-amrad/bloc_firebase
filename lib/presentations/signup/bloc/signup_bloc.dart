import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/abstracts/user_repository.dart';
import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:bloc_firebase/models/alert.dart';
import 'package:bloc_firebase/models/email.dart';
import 'package:bloc_firebase/models/password.dart';
import 'package:bloc_firebase/models/user_store.dart';
import 'package:bloc_firebase/models/username.dart';
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
        final UserCredential userCredential =
            await _authenticationRepository.signup(
          state.email.value,
          state.password.value,
        );
        final user = userCredential.user;
        if (user == null) {
          throw AuthException(message: "Failed get the user");
        }
        await _userRepository.save(
          UserStore(
            user.uid,
            state.username.value,
            user.email!,
            DateTime.now(),
            DateTime.now(),
          ),
        );
        await _authenticationRepository.sendEmailVerification();
        await _authenticationRepository.logout();
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on AuthException catch (e) {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            alert: Alert(message: e.message, type: AlertType.error)));
      } catch (e) {
        rethrow;
      }
    }
  }
}
