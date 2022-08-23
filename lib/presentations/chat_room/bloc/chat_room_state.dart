part of 'chat_room_bloc.dart';

class ChatRoomState extends Equatable {
  @override
  List<Object> get props => [
        text,
        status,
      ];

  final Text text;
  final FormzStatus status;

  ChatRoomState copyWith({
    Text? text,
    FormzStatus? status,
  }) {
    return ChatRoomState(
      text: text ?? this.text,
      status: status ?? this.status,
    );
  }

  const ChatRoomState({
    this.text = const Text.pure(),
    this.status = FormzStatus.pure,
  });
}
