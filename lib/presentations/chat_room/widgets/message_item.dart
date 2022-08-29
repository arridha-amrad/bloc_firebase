import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/domain.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final Message message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(message.body),
          isSender ? const SizedBox(height: 3) : const SizedBox.shrink(),
          isSender
              ? Wrap(
                  children: [
                    Text(
                      DateFormat.Hm().format(message.createdAt),
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.done_all,
                      size: 15,
                      color: message.isRead
                          ? Theme.of(context).brightness == Brightness.light
                              ? Colors.blue
                              : Colors.blue.shade900
                          : Theme.of(context).brightness == Brightness.light
                              ? Colors.grey
                              : Colors.grey[200],
                    )
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
