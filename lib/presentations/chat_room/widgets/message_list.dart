import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_room_bloc.dart';
import 'my_message.dart';
import 'some_one_else_message.dart';

class MessageList extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  MessageList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatRoomBloc, ChatRoomState>(
      listenWhen: (previous, current) => previous.messages != current.messages,
      listener: (context, state) {
        context.read<ChatRoomBloc>().add(ReadMessage());
      },
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        buildWhen: (previous, current) => previous.messages != current.messages,
        builder: (context, state) {
          // automatic scroll to bottom of list
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              {_controller.jumpTo(_controller.position.maxScrollExtent)});
          return ListView.builder(
            controller: _controller,
            shrinkWrap: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              if (message.sender == state.authUserId) {
                return MyMessage(message: message);
              }
              return SomeOneElseMessage(message: message);
            },
          );
        },
      ),
    );
  }
}
