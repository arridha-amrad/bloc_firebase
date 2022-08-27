import 'package:bloc_firebase/domain/domain.dart';

abstract class ChatRepository {
  Future<String> create(Message message, String? chatId);
  Stream<List<Message>> getMessages(String chatId);
  Stream<List<Chat>> getChats();
  Future<void> update(List<Message> messages, String chatId);
  Stream<Message> getMessage(String messageId, String chatId);
}
