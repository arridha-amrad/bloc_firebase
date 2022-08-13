import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/domain/models/user_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepositoryImpl extends UserRepository {
  final _userStore = FirebaseFirestore.instance.collection("users");

  @override
  Future<void> save(UserStore userStore) async {
    await _userStore.doc(userStore.id).set(userStore.toJson());
  }

  @override
  Future<void> update(UserStore userStore) async {
    await _userStore.doc(userStore.id).update(userStore.toJson());
  }
}
