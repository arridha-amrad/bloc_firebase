import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime createdAt;
  final String userId;
  final bool isRead;

  const Message({
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json["text"] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"] as int),
      userId: json["userId"],
      isRead: json["isRead"],
    );
  }

  static Message fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
      text: snapshot["text"],
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(snapshot["createdAt"] as int),
      userId: snapshot["userId"],
      isRead: snapshot["isRead"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "userId": userId,
      "isRead": isRead,
    };
  }
}
