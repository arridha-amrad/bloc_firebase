// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bloc_firebase/domain/models/chat_user.dart';

class Chat {
  final String id;
  final String latestMessage;
  final DateTime latestDate;
  final List<String> members;
  final List<ChatUser> users;

  const Chat({
    required this.id,
    required this.latestDate,
    required this.latestMessage,
    required this.members,
    required this.users,
  });

  static Chat fromSnapshot(DocumentSnapshot snapshot) {
    final members = snapshot["members"] as List<dynamic>;
    final ids = members.map((e) => e as String).toList();
    final users = snapshot["users"] as List<dynamic>;
    final data = users.map((user) => ChatUser.fromMap(user)).toList();
    return Chat(
      id: snapshot["id"] as String,
      latestDate:
          DateTime.fromMillisecondsSinceEpoch(snapshot["latestDate"] as int),
      latestMessage: snapshot["latestMessage"] as String,
      members: ids,
      users: data,
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    final users = json["users"] as List<dynamic>;
    final data = users.map((user) => ChatUser.fromMap(user)).toList();
    return Chat(
      id: json["id"] as String,
      latestDate:
          DateTime.fromMillisecondsSinceEpoch(json["latestDate"] as int),
      latestMessage: json["latestMessage"],
      members: json["members"],
      users: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "latestDate": latestDate.millisecondsSinceEpoch,
      "latestMessage": latestMessage,
      "members": members,
      "users": users,
    };
  }

  @override
  String toString() {
    return 'Chat(id: $id, latestMessage: $latestMessage, latestDate: $latestDate, members: $members, users: $users)';
  }
}
