import 'package:bloc_firebase/domain/domain.dart';
import 'package:bloc_firebase/presentations/chat_room/widgets/chat_field.dart';
import 'package:bloc_firebase/presentations/chat_room/widgets/message_list.dart';
import 'package:bloc_firebase/presentations/chat_room/widgets/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_room_bloc.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserStore? user =
        ModalRoute.of(context)?.settings.arguments as UserStore?;

    return BlocProvider(
      create: (context) => ChatRoomBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user?.username ?? ""),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Column(children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: const MessageList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ChatField(),
                  SizedBox(width: 8),
                  SendButton(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}