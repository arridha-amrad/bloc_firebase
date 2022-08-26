import 'package:bloc_firebase/domain/models/user_store.dart';

abstract class UserRepository {
  Future<void> save(UserStore userStore);
  Stream<List<UserStore>> search(String username);
  Future<void> update(UserStore userStore);
  Future<UserStore> show(String userId);
  Stream<List<UserStore>> showAll();
}
