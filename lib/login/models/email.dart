import 'package:formz/formz.dart';

enum EmailValidationError { inValid, required }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure("");
  const Email.dirty([super.value = ""]) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    if (value == null) {
      return EmailValidationError.required;
    }
    final emailRegexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegexp.hasMatch(value) ? null : EmailValidationError.inValid;
  }
}
