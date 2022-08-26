part of 'chat_room_bloc.dart';

class ChatRoomState extends Equatable {
  @override
  List<Object?> get props =>
      [text, status, authUserId, messages, receiverId, chatId];

  final Text text;
  final FormzStatus status;
  final String authUserId;
  final String receiverId;
  final String? chatId;
  final List<Message> messages;

  ChatRoomState copyWith({
    Text? text,
    FormzStatus? status,
    String? authUserId,
    String? receiverId,
    List<Message>? messages,
    String? chatId,
  }) {
    return ChatRoomState(
      text: text ?? this.text,
      status: status ?? this.status,
      authUserId: authUserId ?? this.authUserId,
      messages: messages ?? this.messages,
      receiverId: receiverId ?? this.receiverId,
      chatId: chatId ?? this.chatId,
    );
  }

  const ChatRoomState({
    this.text = const Text.pure(),
    this.status = FormzStatus.pure,
    this.authUserId = "",
    this.messages = const <Message>[],
    this.receiverId = "",
    this.chatId,
  });
}
