import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/chat_room_bloc.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key? key,
    required this.textController,
    required this.focusNode,
  }) : super(key: key);
  final TextEditingController textController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      buildWhen: (previous, current) => previous.text != current.text,
      builder: (context, state) {
        return IconButton(
          onPressed: state.text.isEmpty
              ? null
              : () {
                  final bloc = context.read<ChatRoomBloc>();
                  bloc.add(Send(textController.text));
                  bloc.add(HideEmojiPicker());
                  focusNode.unfocus();
                  textController.clear();
                },
          icon: const Icon(Icons.send_rounded),
          color: Colors.green,
        );
      },
    );
  }
}
