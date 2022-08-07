import 'package:equatable/equatable.dart';

enum AlertType {
  error,
  success,
  empty,
}

class Alert extends Equatable {
  final String message;
  final AlertType type;

  const Alert({required this.message, required this.type});

  const Alert.empty({
    this.message = "",
    this.type = AlertType.empty,
  });

  @override
  List<Object> get props => [message, type];
}
