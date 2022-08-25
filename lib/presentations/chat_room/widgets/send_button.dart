import 'package:bloc_firebase/presentations/chat_room/model/chat_room.dart';
import 'package:bloc_firebase/presentations/chats/models/chat_extend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_room_bloc.dart';

class SendButton extends StatelessWidget {
  const SendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatRoom chat =
        ModalRoute.of(context)!.settings.arguments as ChatRoom;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.green,
      ),
      child: Center(
        child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () => context.read<ChatRoomBloc>().add(Send()),
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
