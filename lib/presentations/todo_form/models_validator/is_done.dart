import 'package:formz/formz.dart';

enum IsDoneValidationError { required }

class IsDone extends FormzInput<bool, IsDoneValidationError> {
  const IsDone.pure() : super.pure(false);
  const IsDone.dirty([super.value = false]) : super.dirty();

  @override
  IsDoneValidationError? validator(bool? value) {
    if (value == null) {
      return IsDoneValidationError.required;
    }
    return null;
  }
}
