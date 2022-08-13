part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [email, password, message, status];

  final Email email;
  final Password password;
  final FormzStatus status;
  final String message;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.message = "",
  });

  LoginState copyWith(
      {Email? email,
      Password? password,
      FormzStatus? status,
      String? message}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
