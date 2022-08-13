import 'package:formz/formz.dart';

enum DueValidationError { required }

class Due extends FormzInput<int, DueValidationError> {
  const Due.pure() : super.pure(0);
  const Due.dirty([super.value = 0]) : super.dirty();

  @override
  DueValidationError? validator(int value) {
    if (value == 0) {
      return DueValidationError.required;
    }
    return null;
  }
}
