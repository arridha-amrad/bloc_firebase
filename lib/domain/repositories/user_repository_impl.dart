import 'package:bloc_firebase/domain/abstracts/abstracts.dart';
import 'package:bloc_firebase/domain/models/user_store.dart';
import 'package:bloc_firebase/exceptions/user_exception.dart';
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

  @override
  Future<UserStore> show(String userId) async {
    final userFromFirestore = await _userStore.doc(userId).get();
    final data = userFromFirestore.data();
    if (data == null) {
      throw const UserException("User not found");
    }
    return UserStore.fromJson(data);
  }

  @override
  Stream<List<UserStore>> showAll() async* {
    yield* _userStore.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserStore.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<UserStore>> search(String username) async* {
    yield* _userStore
        .orderBy("username")
        .startAt([username])
        .endAt(["$username\uf8ff"])
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => UserStore.fromSnapshot(doc))
              .toList();
        });
  }
}
