import 'package:bloc_firebase/presentations/chat_room/widgets/message_item.dart';
import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class SomeOneElseMessage extends StatelessWidget {
  const SomeOneElseMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.green
              : Colors.green.shade100,
        ),
        padding: const EdgeInsets.all(8),
        child: MessageItem(message: message, isMyMessage: false),
      ),
    );
  }
}
