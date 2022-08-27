import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_room_bloc.dart';

class MessageSendButton extends StatelessWidget {
  const MessageSendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      buildWhen: (previous, current) => previous.text != current.text,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: state.text.value.isNotEmpty ? Colors.green : Colors.grey,
          ),
          child: Center(
              child: IconButton(
            onPressed: state.text.value.isEmpty
                ? null
                : () => context.read<ChatRoomBloc>().add(Send()),
            icon: const Icon(Icons.send_rounded),
            color: Colors.white,
          )),
        );
      },
    );
  }
}
