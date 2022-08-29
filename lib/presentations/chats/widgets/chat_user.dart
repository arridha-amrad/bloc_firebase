import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../../../routes.dart';
import '../../chat_room/model/chat_room.dart';
import '../bloc/chats_bloc.dart';
import '../models/chat_extend.dart';
import 'latest_date_and_sum_unread_messages.dart';
import 'latest_message.dart';

class ChatUser extends StatelessWidget {
  const ChatUser({
    Key? key,
    required this.chatRoom,
    required this.chat,
    required this.chatRepository,
    required this.partner,
    required this.state,
  }) : super(key: key);

  final ChatRoom chatRoom;
  final ChatExtend chat;
  final ChatRepository chatRepository;
  final UserStore partner;
  final ChatsState state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.chatRoom.name, arguments: chatRoom),
      trailing: LatestDateAndSumUnreadMessages(
        chat: chat,
        chatRepository: chatRepository,
      ),
      leading: CircleAvatar(backgroundImage: NetworkImage(partner.avatar)),
      title: Text(partner.username),
      subtitle: LatestMessage(
          chatRepository: chatRepository, chat: chat, state: state),
    );
  }
}
