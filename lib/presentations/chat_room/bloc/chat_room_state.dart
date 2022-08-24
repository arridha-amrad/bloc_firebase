part of 'chat_room_bloc.dart';

class ChatRoomState extends Equatable {
  @override
  List<Object> get props => [text, status, authUserId];

  final Text text;
  final FormzStatus status;
  final String authUserId;

  ChatRoomState copyWith({
    Text? text,
    FormzStatus? status,
    String? authUserId,
  }) {
    return ChatRoomState(
      text: text ?? this.text,
      status: status ?? this.status,
      authUserId: authUserId ?? this.authUserId,
    );
  }

  const ChatRoomState({
    this.text = const Text.pure(),
    this.status = FormzStatus.pure,
    this.authUserId = "",
  });
}
