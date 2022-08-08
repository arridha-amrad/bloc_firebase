import 'package:formz/formz.dart';

enum PasswordValidationError { required, inValid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();
  @override
  PasswordValidationError? validator(String? value) {
    final passwordRegexp = RegExp(
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$");
    if (value == null) {
      return PasswordValidationError.required;
    }
    return passwordRegexp.hasMatch(value)
        ? null
        : PasswordValidationError.inValid;
  }
}
