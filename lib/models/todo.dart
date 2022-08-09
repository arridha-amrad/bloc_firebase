import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDone;
  final String due;
  final String id;

  const Todo({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
    required this.due,
    required this.id,
  });

  @override
  List<Object> get props {
    return [
      id,
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
    String? due,
    String? id,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDone: isDone ?? this.isDone,
      due: due ?? this.due,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
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
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      isDone: map['isDone'] as bool,
      due: map['due'] as String,
    );
  }
}
