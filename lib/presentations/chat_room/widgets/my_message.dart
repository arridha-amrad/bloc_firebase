import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import 'message_item.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 40,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey.shade700,
        ),
        padding: const EdgeInsets.all(8),
        child: MessageItem(message: message, isMyMessage: true),
      ),
    );
  }
}
