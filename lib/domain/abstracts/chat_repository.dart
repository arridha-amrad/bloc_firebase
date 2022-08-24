import 'package:bloc_firebase/domain/domain.dart';

abstract class ChatRepository {
  Future create(Message message);
  Stream<List<Message>> getMessages();
  Stream<List<Chat>> getChats();
}
