import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_room_bloc.dart';

class ChatField extends StatelessWidget {
  const ChatField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          buildWhen: (previous, current) => previous.text != current.text,
          builder: (context, state) {
            return TextFormField(
              onChanged: (value) =>
                  context.read<ChatRoomBloc>().add(TextChanged(value)),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions_outlined)),
                hintText: "Type...",
                border: InputBorder.none,
              ),
            );
          },
        ),
      ),
    );
  }
}
