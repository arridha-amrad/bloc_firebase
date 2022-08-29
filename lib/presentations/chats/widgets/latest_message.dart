import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../bloc/chats_bloc.dart';
import '../models/chat_extend.dart';

class LatestMessage extends StatelessWidget {
  const LatestMessage({
    Key? key,
    required this.chatRepository,
    required this.chat,
    required this.state,
  }) : super(key: key);

  final ChatRepository chatRepository;
  final ChatExtend chat;
  final ChatsState state;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Message>(
      stream: chatRepository.getMessage(chat.latestMessageId, chat.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final message = snapshot.data;
        return Wrap(
          children: [
            message?.sender == state.authUserId
                ? Icon(
                    Icons.done_all,
                    color: message!.isRead ? Colors.blue : Colors.grey,
                    size: 15,
                  )
                : const SizedBox.shrink(),
            const SizedBox(width: 3),
            Text(
              message!.body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }
}
