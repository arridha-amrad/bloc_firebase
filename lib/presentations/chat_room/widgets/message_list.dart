import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_room_bloc.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      buildWhen: (previous, current) => previous.messages != current.messages,
      builder: (context, state) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              if (message.sender == state.authUserId) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 40,
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(message.body)),
                );
              }
              return Align(
                alignment: Alignment.topRight,
                child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 40,
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      message.body,
                      style: const TextStyle(color: Colors.white),
                    )),
              );
            });
      },
    );
  }
}
