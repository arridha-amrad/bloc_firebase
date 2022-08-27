import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/exceptions/todo_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepositoryImpl extends TodoRepository {
  final _todoStore = FirebaseFirestore.instance.collection("todos");
  final _authRepo = AuthenticationRepositoryImpl();

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
    final authUserId = _authRepo.getAuthUser()!.uid;
    yield* _todoStore
        .where("userId", isEqualTo: authUserId)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Todo.fromSnapshot(doc)).toList();
    });
  }
}
