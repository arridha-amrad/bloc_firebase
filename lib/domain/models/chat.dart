import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/domain/models/message.dart';

class Chat {
  final String id;
  final List<Message> messages;
  final List<UserStore> users;

  const Chat({
    required this.id,
    required this.users,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json["id"],
      users: json["users"],
      messages: json["messages"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "messages": messages.map((msg) => msg.toJson()),
    };
  }
}
