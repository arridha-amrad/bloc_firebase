import 'package:formz/formz.dart';

enum DescriptionValidationError { required }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure("");
  const Description.dirty([super.value = ""]) : super.dirty();

  @override
  DescriptionValidationError? validator(String value) {
    if (value.isEmpty) {
      return DescriptionValidationError.required;
    }
    return null;
  }
}
