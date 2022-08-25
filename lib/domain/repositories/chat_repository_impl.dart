import 'package:bloc_firebase/domain/domain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepositoryImpl extends ChatRepository {
  final _roomStore = FirebaseFirestore.instance.collection("rooms");
  final AuthenticationRepository authRepo = AuthenticationRepositoryImpl();

  Future<void> _sendMessageWithChatId(Message message, String chatId) async {
    await _roomStore
        .doc(chatId)
        .collection("messages")
        .doc(message.id)
        .set(message.toJson());
  }

  @override
  Future<void> create(Message message, String? chatId) async {
    if (chatId == null) {
      await _sendMessageWithChatId(message, chatId!);
    }
    await _roomStore.doc(chatId).update({
      "latestMessage": message.body,
      "latestDate": message.createdAt.millisecondsSinceEpoch,
    });
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
  Stream<List<Message>> getMessages(String chatId) async* {
    yield* _roomStore
        .doc(chatId)
        .collection("messages")
        .orderBy("createdAt")
        .snapshots()
        .map((snapshot) {
      final result =
          snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList();
      return result;
    });
  }
}
