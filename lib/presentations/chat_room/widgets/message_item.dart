import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
    required this.isMyMessage,
  }) : super(key: key);

  final Message message;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(message.body),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat.jm().format(message.createdAt),
              style: const TextStyle(fontSize: 10),
            ),
            isMyMessage ? const SizedBox(width: 8) : const SizedBox.shrink(),
            isMyMessage
                ? Icon(
                    Icons.check,
                    size: 12,
                    color: message.isRead
                        ? Colors.blue
                        : Theme.of(context).textTheme.bodyText1!.color,
                  )
                : const SizedBox.shrink()
          ],
        )
      ],
    );
  }
}
