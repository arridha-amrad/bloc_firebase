import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:bloc_firebase/models/alert.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepository _authenticationRepository;

  SignupBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(const SignupState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSubmit);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    final String email = event.email;
    final emailRegexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegexp.hasMatch(email)) {
      emit(state.copyWith(email: email, isEmailValid: true));
    } else {
      emit(state.copyWith(email: email, isEmailValid: false));
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    final String password = event.password;
    // Minimum six characters, at least one letter, one number and one special character:
    final passwordRegexp = RegExp(
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$");
    if (passwordRegexp.hasMatch(password)) {
      emit(state.copyWith(password: event.password, isPasswordValid: true));
    } else {
      emit(state.copyWith(password: password, isPasswordValid: false));
    }
  }

  Future<void> _onSubmit(
      SignUpSubmitted event, Emitter<SignupState> emit) async {
    try {
      final UserCredential userCredential =
          await _authenticationRepository.signup(state.email, state.password);
      print("============ user : $userCredential");
    } on AuthException catch (e) {
      emit(state.copyWith(
          alert: Alert(message: e.message, type: AlertType.error)));
    } catch (e) {
      rethrow;
    }
  }
}
