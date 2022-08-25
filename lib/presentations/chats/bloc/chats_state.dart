part of 'chats_bloc.dart';

class ChatsState extends Equatable {
  final List<Chat> chats;
  final List<ChatExtend> myChats;
  final String authUserId;
  final bool isLoading;

  const ChatsState({
    this.chats = const <Chat>[],
    this.myChats = const <ChatExtend>[],
    this.authUserId = "",
    this.isLoading = true,
  });

  ChatsState copyWith({
    List<Chat>? chats,
    List<ChatExtend>? myChats,
    String? authUserId,
    bool? isLoading,
  }) {
    return ChatsState(
      chats: chats ?? this.chats,
      authUserId: authUserId ?? this.authUserId,
      myChats: myChats ?? this.myChats,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [chats, authUserId, myChats, isLoading];
}
