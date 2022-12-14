import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';

import '../../../domain/domain.dart';
import 'message_item.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({
    Key? key,
    required this.message,
    required this.index,
  }) : super(key: key);

  final Message message;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
        elevation: 0,
        clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.green[100]
            : Colors.green,
        child: MessageItem(
          message: message,
          isSender: true,
        ));
  }
}
