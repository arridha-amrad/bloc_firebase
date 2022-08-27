import 'package:bloc_firebase/domain/domain.dart';

class ChatExtend extends Chat {
  final UserStore partner;
  ChatExtend({
    required super.id,
    required super.latestDate,
    required super.latestMessageId,
    required super.members,
    required this.partner,
  });
}
