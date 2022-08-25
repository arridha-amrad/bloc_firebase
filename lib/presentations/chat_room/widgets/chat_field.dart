import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/chat_room_bloc.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key}) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  TextEditingController textCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: BlocListener<ChatRoomBloc, ChatRoomState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              textCon.clear();
            }
          },
          child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
            buildWhen: (previous, current) => previous.text != current.text,
            builder: (context, state) {
              return TextFormField(
                controller: textCon,
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
      ),
    );
  }
}
