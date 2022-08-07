part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String email;
  final String password;

  final bool isEmailValid;
  final bool isPasswordValid;

  final Alert alert;

  const SignupState({
    this.email = "",
    this.password = "",
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.alert = const Alert.empty(),
  });

  SignupState copyWith(
      {String? email,
      String? password,
      bool? isEmailValid,
      bool? isPasswordValid,
      Alert? alert}) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      alert: alert ?? this.alert,
    );
  }

  @override
  List<Object> get props => [email, password];
}
