import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final String latestMessageId;
  final DateTime latestDate;
  final List<String> members;

  const Chat({
    required this.id,
    required this.latestDate,
    required this.latestMessageId,
    required this.members,
  });

  static Chat fromSnapshot(DocumentSnapshot snapshot) {
    final members = snapshot["members"] as List<dynamic>;
    final ids = members.map((e) => e as String).toList();
    return Chat(
      id: snapshot["id"] as String,
      latestDate:
          DateTime.fromMillisecondsSinceEpoch(snapshot["latestDate"] as int),
      latestMessageId: snapshot["latestMessageId"] as String,
      members: ids,
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json["id"] as String,
      latestDate:
          DateTime.fromMillisecondsSinceEpoch(json["latestDate"] as int),
      latestMessageId: json["latestMessageId"],
      members: json["members"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "latestDate": latestDate.millisecondsSinceEpoch,
      "latestMessageId": latestMessageId,
      "members": members,
    };
  }

  @override
  String toString() {
    return 'Chat(id: $id, latestMessageId: $latestMessageId, latestDate: $latestDate, members: $members,)';
  }
}
