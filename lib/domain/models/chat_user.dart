// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatUser {
  final String id;
  final String username;
  final String avatar;

  ChatUser({
    required this.id,
    required this.username,
    required this.avatar,
  });

  ChatUser copyWith({
    String? id,
    String? username,
    String? avatar,
  }) {
    return ChatUser(
      id: id ?? this.id,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      "avatar": avatar,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'] as String,
      username: map['username'] as String,
      avatar: map["avatar"] as String,
    );
  }

  @override
  String toString() =>
      'ChatUser(id: $id, username: $username, avatar: $avatar)';
}
