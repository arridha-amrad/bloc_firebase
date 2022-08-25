// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatRoom {
  final String userId;
  final String avatar;
  final String username;
  final String? chatId;

  ChatRoom({
    required this.userId,
    required this.avatar,
    required this.username,
    this.chatId,
  });

  ChatRoom copyWith({
    String? userId,
    String? avatar,
    String? username,
    String? chatId,
  }) {
    return ChatRoom(
      userId: userId ?? this.userId,
      avatar: avatar ?? this.avatar,
      username: username ?? this.username,
    );
  }

  @override
  String toString() {
    return 'ChatRoom(userId: $userId, avatar: $avatar, username: $username, chatId: $chatId)';
  }
}
