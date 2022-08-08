part of 'signup_bloc.dart';

class SignupState extends Equatable {
  @override
  List<Object> get props => [email, password, alert, status, username];

  final Email email;
  final Password password;
  final Username username;
  final FormzStatus status;
  final Alert alert;

  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.alert = const Alert.empty(),
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
  });

  SignupState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    Alert? alert,
    Username? username,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      alert: alert ?? this.alert,
      username: username ?? this.username,
    );
  }
}
