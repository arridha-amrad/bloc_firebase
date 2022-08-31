import 'package:bloc_firebase/presentations/chat_room/widgets/message_form/emoji_lists.dart';
import 'package:bloc_firebase/presentations/chat_room/widgets/message_form/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../bloc/chat_room_bloc.dart';
import 'send_button.dart';

class MessageForm extends StatefulWidget {
  const MessageForm({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageForm> createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      buildWhen: (previous, current) => previous.text != current.text,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(bottom: 4, top: 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.read<ChatRoomBloc>().add(ToggleEmojiPicker());
                    },
                    icon: const Icon(Icons.emoji_emotions_outlined),
                  ),
                  Expanded(
                      child: TextInput(
                    textController: textController,
                    focusNode: _focusNode,
                  )),
                  const SizedBox(width: 8),
                  SendButton(
                    focusNode: _focusNode,
                    textController: textController,
                  ),
                ],
              ),
              EmojiLists(textCon: textController)
            ],
          ),
        );
      },
    );
  }
}
