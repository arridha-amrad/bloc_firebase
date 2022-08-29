import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/domain/repositories/chat_repository_impl.dart';
import 'package:bloc_firebase/presentations/chat_room/model/chat_room.dart';
import 'package:bloc_firebase/presentations/chat_room/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_room_bloc.dart';
import 'widgets/message_input.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatRoom chatRoom = ModalRoute.of(context)?.settings.arguments as ChatRoom;

    return BlocProvider(
      create: (context) => ChatRoomBloc(
        authenticationRepository: AuthenticationRepositoryImpl(),
        chatRepository: ChatRepositoryImpl(),
      )..add(InitRoom(chatRoom)),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(chatRoom.avatar),
              ),
              const SizedBox(width: 12),
              Text(chatRoom.username),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey[200]
                : Colors.grey.shade900,
          ),
          child: Column(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[200]
                      : Colors.grey.shade900,
                ),
                child: MessageList(),
              ),
            ),
            const MessageInput(),
          ]),
        ),
      ),
    );
  }
}
