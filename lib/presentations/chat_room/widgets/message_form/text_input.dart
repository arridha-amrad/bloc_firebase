import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_room_bloc.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.focusNode,
    required this.textController,
  }) : super(key: key);
  final TextEditingController textController;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatRoomBloc, ChatRoomState>(
      listenWhen: (previous, current) =>
          previous.isHideEmojiPicker != current.isHideEmojiPicker,
      listener: (context, state) {
        if (!state.isHideEmojiPicker) {
          focusNode.unfocus();
        }
      },
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        buildWhen: (previous, current) => previous.text != current.text,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade700
                        : Colors.grey.shade200),
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey.shade700
                    : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: TextFormField(
              onTap: () {
                context.read<ChatRoomBloc>().add(HideEmojiPicker());
              },
              controller: textController,
              focusNode: focusNode,
              onChanged: (value) {
                context.read<ChatRoomBloc>().add(TextChanged(value));
              },
              minLines: 1,
              maxLines: 4,
              cursorColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade700
                      : Colors.white,
                  hintText: "Type...",
                  border: InputBorder.none),
            ),
          );
        },
      ),
    );
  }
}
