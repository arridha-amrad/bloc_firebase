part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [email, password, alert, status];

  final Email email;
  final Password password;
  final FormzStatus status;
  final Alert alert;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.alert = const Alert.empty(),
  });

  LoginState copyWith(
      {Email? email, Password? password, FormzStatus? status, Alert? alert}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      alert: alert ?? this.alert,
      status: status ?? this.status,
    );
  }
}
