import 'package:formz/formz.dart';

enum TextValidationError { required }

class Text extends FormzInput<String, TextValidationError> {
  const Text.pure() : super.pure("");
  const Text.dirty([super.value = ""]) : super.dirty();

  @override
  TextValidationError? validator(String? value) {
    if (value == null) {
      return TextValidationError.required;
    }
    return null;
  }
}
