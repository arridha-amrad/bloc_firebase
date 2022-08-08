import 'package:equatable/equatable.dart';

class UserStore extends Equatable {
  @override
  List<Object?> get props => [id, username, email, createdAt];

  final String id;
  final String username;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserStore(
    this.id,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  UserStore copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserStore(
      id ?? this.id,
      username ?? this.username,
      email ?? this.email,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }
}
