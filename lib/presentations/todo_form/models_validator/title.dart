import 'package:formz/formz.dart';

enum TitleValidationError { required }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.pure() : super.pure("");
  const Title.dirty([super.value = ""]) : super.dirty();

  @override
  TitleValidationError? validator(String value) {
    if (value.isEmpty) {
      return TitleValidationError.required;
    }
    return null;
  }
}
