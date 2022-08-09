import 'package:bloc_firebase/abstracts/todo_repository.dart';
import 'package:bloc_firebase/exceptions/todo_exception.dart';
import 'package:bloc_firebase/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepositoryImpl extends TodoRepository {
  final _todoStore = FirebaseFirestore.instance.collection("todos");

  @override
  Future<void> delete(Todo todo) async {
    try {
      await _todoStore.doc(todo.id).delete();
    } catch (e) {
      throw const TodoException("Failure when deleting todo");
    }
  }

  @override
  Future<void> save(Todo todo) async {
    await _todoStore.add(todo.toMap());
  }

  @override
  Future<void> update(Todo todo) async {
    await _todoStore.doc(todo.id).update(todo.toMap());
  }
}
