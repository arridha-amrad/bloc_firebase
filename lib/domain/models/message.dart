import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String body;
  final DateTime createdAt;
  final String sender;
  final String receiver;
  final bool isRead;

  const Message({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.isRead,
    required this.receiver,
    required this.sender,
  });

  Message copyWith({
    String? id,
    String? body,
    String? sender,
    String? receiver,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      receiver: receiver ?? this.receiver,
      sender: sender ?? this.sender,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      body: json["body"] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"] as int),
      sender: json["sender"] as String,
      receiver: json["receiver"] as String,
      id: json["id"] as String,
      isRead: json["isRead"] as bool,
    );
  }

  static Message fromSnapshot(DocumentSnapshot snapshot) {
    return Message(
      id: snapshot["id"] as String,
      body: snapshot["body"] as String,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(snapshot["createdAt"] as int),
      isRead: snapshot["isRead"] as bool,
      sender: snapshot["sender"] as String,
      receiver: snapshot["receiver"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "isRead": isRead,
      "body": body,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "sender": sender,
      "receiver": receiver,
    };
  }
}
