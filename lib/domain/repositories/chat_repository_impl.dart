import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/exceptions/chat_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

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
  Future<void> update(List<Message> messages, String chatId) async {
    final messagesCollection = _roomStore.doc(chatId).collection("messages");
    for (var msg in messages) {
      await messagesCollection.doc(msg.id).update({"isRead": true});
    }
  }

  @override
  Future<String> create(Message message, String? chatId) async {
    String roomId = "";
    if (chatId == null) {
      roomId = const Uuid().v4();
      await _roomStore.doc(roomId).set({
        "id": roomId,
        "members": [message.sender, message.receiver],
        "latestMessageId": message.id,
        "latestDate": message.createdAt.millisecondsSinceEpoch,
      });
    } else {
      await _roomStore.doc(chatId).update({
        "latestMessageId": message.id,
        "latestDate": message.createdAt.millisecondsSinceEpoch,
      });
      roomId = chatId;
    }
    await _sendMessageWithChatId(message, roomId);
    return roomId;
  }

  @override
  Stream<List<Chat>> getChats() async* {
    final authUserId = authRepo.getAuthUser()!.uid;
    yield* _roomStore
        .where("members", arrayContains: authUserId)
        .orderBy("latestDate", descending: true)
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

  @override
  Stream<Message> getMessage(String messageId, String chatId) async* {
    yield* _roomStore
        .doc(chatId)
        .collection("messages")
        .doc(messageId)
        .snapshots()
        .map((snap) {
      final doc = snap.data();
      if (doc == null) {
        throw ChatException("chat not found");
      }
      final result = Message.fromJson(doc);
      return result;
    });

    // final Map<String, dynamic>? message = doc.data();

    // if (message == null) {
    //   throw const ChatException("Chat not found");
    // }

    // return Message.fromJson(message);
  }
}
