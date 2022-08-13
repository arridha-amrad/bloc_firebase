part of 'signup_bloc.dart';

class SignupState extends Equatable {
  @override
  List<Object> get props => [email, password, message, status, username];

  final Email email;
  final Password password;
  final Username username;
  final FormzStatus status;
  final String message;

  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.message = "",
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
  });

  SignupState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? message,
    Username? username,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      username: username ?? this.username,
    );
  }
}
