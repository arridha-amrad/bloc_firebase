part of 'chat_room_bloc.dart';

class ChatRoomState extends Equatable {
  @override
  List<Object?> get props => [
        text,
        status,
        authUserId,
        messages,
        receiverId,
        chatId,
        isHideEmojiPicker
      ];

  final String text;
  final FormzStatus status;
  final String authUserId;
  final String receiverId;
  final String? chatId;
  final List<Message> messages;
  final bool isHideEmojiPicker;

  ChatRoomState copyWith({
    String? text,
    FormzStatus? status,
    String? authUserId,
    String? receiverId,
    List<Message>? messages,
    String? chatId,
    bool? isHideEmojiPicker,
  }) {
    return ChatRoomState(
      text: text ?? this.text,
      status: status ?? this.status,
      authUserId: authUserId ?? this.authUserId,
      messages: messages ?? this.messages,
      receiverId: receiverId ?? this.receiverId,
      chatId: chatId ?? this.chatId,
      isHideEmojiPicker: isHideEmojiPicker ?? this.isHideEmojiPicker,
    );
  }

  const ChatRoomState({
    this.text = "",
    this.status = FormzStatus.pure,
    this.authUserId = "",
    this.messages = const <Message>[],
    this.receiverId = "",
    this.chatId,
    this.isHideEmojiPicker = true,
  });
}
