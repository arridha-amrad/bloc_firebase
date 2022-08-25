import 'package:bloc_firebase/domain/domain.dart';

abstract class ChatRepository {
  Future create(Message message, String chatId);
  Stream<List<Message>> getMessages(String chatId);
  Stream<List<Chat>> getChats();
}
