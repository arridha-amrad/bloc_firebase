import 'package:bloc_firebase/presentations/chat_room/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';

import '../../../domain/domain.dart';

class SomeOneElseMessage extends StatelessWidget {
  const SomeOneElseMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
      elevation: 0,
      backGroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.grey,
      margin: const EdgeInsets.only(top: 20),
      child: MessageItem(message: message, isSender: false),
    );
  }
}
