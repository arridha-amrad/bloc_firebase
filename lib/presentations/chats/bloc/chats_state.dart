part of 'chats_bloc.dart';

class ChatsState extends Equatable {
  final List<Chat> chats;
  final String authUserId;

  const ChatsState({
    this.chats = const <Chat>[],
    this.authUserId = "",
  });

  ChatsState copyWith({
    List<Chat>? chats,
    String? authUserId,
  }) {
    return ChatsState(
      chats: chats ?? this.chats,
      authUserId: authUserId ?? this.authUserId,
    );
  }

  @override
  List<Object> get props => [
        chats,
        authUserId,
      ];
}
