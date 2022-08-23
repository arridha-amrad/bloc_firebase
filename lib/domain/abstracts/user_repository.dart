import 'package:bloc_firebase/domain/models/user_store.dart';

abstract class UserRepository {
  Future<void> save(UserStore userStore);
  Future<void> update(UserStore userStore);
  Future<UserStore> show(String userId);
  Stream<List<UserStore>> showAll();
}
