import 'package:flutter/material.dart';

import 'chat_field.dart';
import 'message_send_button.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChatField(),
            SizedBox(width: 8),
            MessageSendButton(),
          ],
        ),
      ],
    );
  }
}
