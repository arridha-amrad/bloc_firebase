import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_firebase/abstracts/authentication_repository.dart';
import 'package:bloc_firebase/exceptions/auth_exception.dart';
import 'package:bloc_firebase/login/models/password.dart';
import 'package:bloc_firebase/models/alert.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

import '../models/email.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc(AuthenticationRepository authenticationRepository)
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmit);
    on<LoginAlertCleared>(_onClear);
  }

  void _onClear(LoginAlertCleared event, Emitter<LoginState> emit) {
    // emit(state.copyWith(status: Status.idle));
  }

  Future<void> _onSubmit(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.login(
          state.email.value,
          state.password.value,
        );
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

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password, status: Formz.validate([password, state.email])));
  }
}
