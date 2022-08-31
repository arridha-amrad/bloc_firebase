import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_room_bloc.dart';
import 'my_message.dart';
import 'some_one_else_message.dart';

class MessageList extends StatelessWidget {
  final ScrollController _controller = ScrollController();
  MessageList({Key? key}) : super(key: key);
  final itemKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatRoomBloc, ChatRoomState>(
      listenWhen: (previous, current) => previous.messages != current.messages,
      listener: (context, state) {
        context.read<ChatRoomBloc>().add(ReadMessage());
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            if (_controller.hasClients) {
              _controller.jumpTo(
                _controller.position.maxScrollExtent,
              );
            }
          },
        );
      },
      child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
        buildWhen: (previous, current) => previous.messages != current.messages,
        builder: (context, state) {
          return ListView.builder(
            controller: _controller,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              if (message.sender == state.authUserId) {
                return MyMessage(
                  message: message,
                  index: index,
                );
              }
              return SomeOneElseMessage(message: message);
            },
          );
        },
      ),
    );
  }
}
