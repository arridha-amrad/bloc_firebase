import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/exceptions/todo_exception.dart';
import 'package:bloc_firebase/domain/models/todo.dart';
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
    try {
      await _todoStore.doc(todo.id).set(todo.toMap());
    } catch (e) {
      throw const TodoException("Failed to store todo");
    }
  }

  @override
  Future<void> update(Todo todo) async {
    try {
      await _todoStore.doc(todo.id).update(todo.toMap());
    } catch (e) {
      throw const TodoException("Failed to update the todo");
    }
  }

  @override
  Stream<List<Todo>> getAllTodos() async* {
    yield* _todoStore
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Todo.fromSnapshot(doc)).toList();
    });
  }
}
