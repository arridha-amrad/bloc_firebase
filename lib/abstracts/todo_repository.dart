import 'package:bloc_firebase/models/todo.dart';

abstract class TodoRepository {
  Future<void> save(Todo todo);
  Future<void> delete(Todo todo);
  Future<void> update(Todo todo);
  Stream<List<Todo>> getAllTodos();
}
