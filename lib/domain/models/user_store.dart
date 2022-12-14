import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserStore extends Equatable {
  @override
  List<Object?> get props => [id, username, email, createdAt, avatar];

  final String id;
  final String username;
  final String email;
  final String avatar;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserStore(
    this.id,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.avatar,
  );

  factory UserStore.fromJson(Map<String, dynamic> json) {
    return UserStore(
      json["id"] as String,
      json["username"] as String,
      json["email"] as String,
      DateTime.parse(json["createdAt"] as String),
      DateTime.parse(json["updatedAt"] as String),
      json["avatar"] as String,
    );
  }

  static UserStore fromSnapshot(DocumentSnapshot snap) {
    return UserStore(
      snap["id"] as String,
      snap["username"] as String,
      snap["email"] as String,
      DateTime.parse(snap["createdAt"] as String),
      DateTime.parse(snap["updatedAt"] as String),
      snap["avatar"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "avatar": avatar,
    };
  }

  UserStore copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avatar,
  }) {
    return UserStore(
      id ?? this.id,
      username ?? this.username,
      email ?? this.email,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
      avatar ?? this.avatar,
    );
  }
}
