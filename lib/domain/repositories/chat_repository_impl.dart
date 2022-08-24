import 'package:bloc_firebase/domain/domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepositoryImpl extends ChatRepository {
  final _roomStore = FirebaseFirestore.instance.collection("rooms");
  final AuthenticationRepository authRepo = AuthenticationRepositoryImpl();
  @override
  Future create(Message message) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Stream<List<Chat>> getChats() async* {
    final authUserId = authRepo.getAuthUser()!.uid;
    yield* _roomStore
        .where("members", arrayContains: authUserId)
        .snapshots()
        .map((snapshot) {
      final result =
          snapshot.docs.map((doc) => Chat.fromSnapshot(doc)).toList();
      return result;
    });
  }

  @override
  Stream<List<Message>> getMessages() {
    // TODO: implement getMessages
    throw UnimplementedError();
  }
}
