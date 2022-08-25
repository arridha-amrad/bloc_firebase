import 'package:bloc_firebase/domain/models/chat.dart';
import 'package:bloc_firebase/domain/models/user_store.dart';

class ChatExtend extends Chat {
  final UserStore partner;
  ChatExtend({
    required super.id,
    required super.latestDate,
    required super.latestMessage,
    required super.members,
    required this.partner,
  });
}
