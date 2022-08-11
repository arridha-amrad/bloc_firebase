import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDone;
  final int due;

  const Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
    required this.due,
  });

  Todo.empty({
    DateTime? createdAt,
    DateTime? updatedAt,
    this.id = "",
    this.description = "",
    this.due = 0,
    this.isDone = false,
    this.title = "",
    this.userId = "",
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  List<Object> get props {
    return [
      id,
      userId,
      title,
      description,
      createdAt,
      updatedAt,
      isDone,
      due,
    ];
  }

  Todo copyWith({
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDone,
    int? due,
    String? id,
    String? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDone: isDone ?? this.isDone,
      due: due ?? this.due,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isDone': isDone,
      'due': due,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      isDone: map['isDone'] as bool,
      due: map['due'] as int,
    );
  }

  static Todo fromSnapshot(DocumentSnapshot snap) {
    return Todo(
      id: snap['id'] as String,
      userId: snap['userId'] as String,
      title: snap['title'] as String,
      description: snap['description'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(snap['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(snap['updatedAt'] as int),
      isDone: snap['isDone'] as bool,
      due: snap['due'] as int,
    );
  }
}
