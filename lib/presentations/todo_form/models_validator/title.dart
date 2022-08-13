import 'package:formz/formz.dart';

enum TitleVaidationError { required }

class Title extends FormzInput<String, TitleVaidationError> {
  const Title.pure() : super.pure("");
  const Title.dirty([super.value = ""]) : super.dirty();

  @override
  TitleVaidationError? validator(String value) {
    if (value.isEmpty) {
      return TitleVaidationError.required;
    }
    return null;
  }
}
