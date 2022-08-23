import 'package:bloc_firebase/domain/models/message.dart';

abstract class ChatRepository {
  Future create(Message message);
  Stream<List<Message>> getMessages();
}
