part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object?> get props => [];
}

class TextChanged extends ChatRoomEvent {
  final String text;
  const TextChanged(this.text);
  @override
  List<Object> get props => [text];
}

class Send extends ChatRoomEvent {
  final String chatId;
  const Send(this.chatId);
  @override
  List<Object> get props => [chatId];
}

class InitRoom extends ChatRoomEvent {
  final ChatExtend? chat;
  const InitRoom(this.chat);
  @override
  List<Object?> get props => [chat];
}
